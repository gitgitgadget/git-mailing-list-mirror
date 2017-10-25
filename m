Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3F4202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 12:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdJYMwD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 08:52:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:63289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdJYMwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 08:52:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzXTy-1d3sX43loo-014lwc; Wed, 25
 Oct 2017 14:51:45 +0200
Date:   Wed, 25 Oct 2017 14:51:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
In-Reply-To: <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710251437090.6482@virtualbox>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com> <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com> <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eYnOOqE0LyxKnseDaIW/bpwapAQJyrtgiasrH2FXW45zjM824I3
 Jca0lkw/4Urh4ZpJTKdMnNLgMyGO4oJf0A0RpqsFY2+xcBJ100Fcj03lRVD+hpRqEQg2IOO
 r8o4X+b1Sqg1CWlFsm7BoIVivz2HXkqOY7mowW+2DCJAz1RtHtwIGPiwEOJs4E7Bnu6J1cI
 rbvIJuOb9OGjdFZbiP75Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:669mMmyTe+M=:oNRR9XvBsy0LUs3i1YpP7a
 55DjfS6wych6rsl+PX6BIkveLRqEIUcRwMGaZooG56fybz5bIKE1KbBuFYrZip5P4QHcOGDqQ
 wpybsJZa08lf9ISR5gtjoERNivOkvYRIhGDRhACIRf0jIErnd6XEesvSwHCx+lJZL0IGeX4C4
 AGWdIf6TiOsymc8+OQs6TYbYoEPdnZjqz40G2HV+ugKzCE3vfc7PLc3fZwgd5Eg5fcEcr0hVE
 8LYECVyAkdKjOHRSe8gNvUQEE7MkNaUjBzrJHLC+ieT2k0aM8dXnwJSmuwN2UJWnCWYhtW2GP
 97j0mrFjSvwvNARq+25PwL4ecqimV4xHga+vyD0bLRRYjYX6NfJmPPPO7u1JMehh80Ny6wIbi
 ZcCEEdeoS2ZzCmD4kK5PXmlHbEb9FiOYupvDcC1y4Vk5AORucU8Xc4mg7CQFTSUY5B8f18mmb
 E6TPseGXbmYoYtafRxQNaN4NujSOxlNfG5opWvzC8FWBzAkQXKH12/hyoZcd1h1kjhqOAwWHu
 6dSX9o16drPgH+YZOhXgz98P0nha8FkogvxNPi8PEWvORoqDVPyIoDtiN1brAyG5MdYrk3mg4
 aCcRQfxQ0IK89+lTUl6ViX9T02OC6oAVw+8ThvH6KHyremRFSUQmYubNwGyp/w+rixKLq+kXV
 /49BSlQm+3ZRAcPcYVfGxYgswFUeFoFQq/Lp8AsS0yLayWbuzJpBTKjK0vucDr+YlpnPSw+CE
 o+GJPud4SZiwZB+UQt6mAu2l9tbcC9aD69kOvrjj+VNnG2wo+yir0/uGifgUrlE6qQvHNzWPc
 QDzFQuLUky0VfEYlX3VPcIVrCnyADWFVaUpJ1nA3n2ZjyGp3abmiPRAL1CDTbuylPik1O7R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

[I only saw that you replied to 3/5 with v2 after writing this reply, but
it would apply to v2's 3/5, too]

On Mon, 23 Oct 2017, Jonathan Nieder wrote:

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 86811a0c35..fd94dd40d2 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -384,6 +384,20 @@ test_expect_success 'uplink is treated as simple' '
>  	expect_ssh myhost src
>  '
>  
> +test_expect_success 'OpenSSH-like uplink is treated as ssh' '
> +	write_script "$TRASH_DIRECTORY/uplink" <<-EOF &&
> +	if test "\$1" = "-G"
> +	then
> +		exit 0
> +	fi &&
> +	exec "\$TRASH_DIRECTORY/ssh$X" "\$@"
> +	EOF
> +	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
> +	export GIT_SSH &&
> +	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> +	expect_ssh "-p 123" myhost src
> +'
> +
>  test_expect_success 'plink is treated specially (as putty)' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&

This breaks on Windows. And it is not immediately obvious how so, so let
me explain:

As you know, on Windows there is no executable flag. There is the .exe
file extension to indicate an executable (and .com and .bat and .cmd are
also handled as executable, at least as executable script).

Now, what happens if you call "abc" in the MSYS2 Bash and there is no
script called "abc" but an executable called "abc.exe" in the PATH? Why,
of course we execute that executable. It has to, because if "abc.exe"
would be renamed into "abc", it would not work any longer.

That is also the reason why that "copy_ssh_wrapper" helper function
automatically appends that .exe file suffix on Windows: it has to.

Every workaround breaks down at some point, and this workaround is no
exception. What should the MSYS2 Bash do if asked to overwrite "abc" and
there is only an "abc.exe"? It actually overwrites "abc.exe" and moves on.

And this is where we are here: the previous test case copied the ssh
wrapper as "uplink". Except on Windows, it is "uplink.exe". And your newly
introduced test case overwrites it. And then it tells Git specifically to
look for "uplink", and Git does *not* append that .exe suffix
automatically as the MSYS2 Bash would do, because git.exe is not intended
to work MSYS2-like.

As a consequence, the test fails. Could you please squash in this, to fix
the test on Windows?

-- snipsnap --
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index ec4b17bca62..1afcbd00617 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -393,6 +393,7 @@ test_expect_success 'simple does not support port' '
 
 test_expect_success 'uplink is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
+	test_when_finished "rm \"$TRASH_DIRECTORY/uplink$X\"" &&
 	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
 	git clone "myhost:src" ssh-clone-uplink &&
 	expect_ssh myhost src

