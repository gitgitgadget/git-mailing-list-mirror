From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH] notes: Allow adding empty notes with -C
Date: Sun, 21 Sep 2014 10:53:23 +0200
Message-ID: <541E9203.9040702@web.de>
References: <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com> <1411268449-14636-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: jhf@trifork.com
To: Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 10:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVctt-0000Iv-Gb
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 10:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbaIUIxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 04:53:32 -0400
Received: from mout.web.de ([212.227.15.14]:55912 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbaIUIxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 04:53:31 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Ldn19-1YDFFl2p7r-00ixtK; Sun, 21 Sep 2014 10:53:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1411268449-14636-1-git-send-email-johan@herland.net>
X-Provags-ID: V03:K0:Si1BxQ6dwMrCMZw4SYaEiBG4zUOwM7uFIFqjQg7oawIsqsHr2ov
 IiWAZ6wN1IDZsUrktKimHj3iE3keEuWCLlnlRYMfQQkeuxnM+fVvAdUHxJG4rmsEty/4wir
 QUoIh2fP0/P3lXpQ63HskrASnM5qW1QVcwxSTP+72d/QjqiinKjnOYrU4316bdWOwvxpQa4
 hz9jtP9v+g15lzJ2B/0cQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257344>

On 2014-09-21 05.00, Johan Herland wrote:
[]
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index cfd67ff..a6c399b 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1239,4 +1239,23 @@ test_expect_success 'git notes get-ref (--ref)' '
>  	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
>  '
>  
> +cat > expect << EOF
Git style for shell scripts: Plase put no space between < or > or >> and the file name:
cat >expect <<EOF

> +commit 085b0d1309902c3148feb5a136515bdb9a1cd614
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:28:13 2005 -0700
> +
> +    16th
> +
> +Notes (foo):
> +EOF
> +
> +test_expect_success 'can create empty note with "git notes add -C $empty_blob"' '
> +	test_commit 16th &&
> +	blob=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
> +	git notes add -C $blob &&
> +	git log -1 > actual &&
git log -1 >actual &&

> +	test_cmp expect actual &&
> +	test "$(git notes list HEAD)" = "$blob"
> +'
> +
>  test_done
> 
