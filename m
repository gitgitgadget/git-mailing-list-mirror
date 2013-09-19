From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
Date: Thu, 19 Sep 2013 09:37:41 -0700
Message-ID: <xmqqsix0u5re.fsf@gitster.dls.corp.google.com>
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
	<20130919133920.GA22468@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Madhavan Srinivasan <maddy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	steven.hill-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, mmarek-AlSwsSmVLrQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
X-From: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Thu Sep 19 18:37:49 2013
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: gldd-devicetree-discuss-2-wOFGN7rlS/M9smdsby/KFg@public.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>)
	id 1VMhEh-0001V3-Ga
	for gldd-devicetree-discuss-2-wOFGN7rlS/M9smdsby/KFg@public.gmane.org; Thu, 19 Sep 2013 18:37:47 +0200
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1751933Ab3ISQhq (ORCPT
	<rfc822;gldd-devicetree-discuss-2@m.gmane.org>);
	Thu, 19 Sep 2013 12:37:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab3ISQhp (ORCPT <rfc822;devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Thu, 19 Sep 2013 12:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9642F42B53;
	Thu, 19 Sep 2013 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AuHW/s+tAUyCoTXvCK6pvXSMNKI=; b=VtrFl2
	1M3lSYfV0N9XMdNnr3AP8pXcp0N0gILzaE2YsvLZ2BM0vpK9xJECTm1jTPgrYpwI
	w51KFeN0XUajb+SoDRdiQVvgdSemCt2w0vuaSEAzuHTaPAO8Wy7Ul8vKhs9nFMCr
	1uUIRh1YZey82fnj2P26vXxv8Tteu2V6wbtmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vQSBaCat86G2GvYT6Q6VVwSgvHkNSpoc
	KiYHzoXMP5p77DieMfInR1e+1+hEgY2S+P2CqHIf1XONQqImE8+sWyhEZXn/cslu
	3g4EN5ZyqPMQQGo8KahwTVeggrUNX+EEuEXjSb9QKuD2vmmtdpsHBYFIFKi7qFip
	yCPpUhR3vf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A0D642B52;
	Thu, 19 Sep 2013 16:37:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D393C42B50;
	Thu, 19 Sep 2013 16:37:43 +0000 (UTC)
In-Reply-To: <20130919133920.GA22468-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> (Ralf Baechle's message
	of "Thu, 19 Sep 2013 15:39:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CEF1B71A-2149-11E3-9DD3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
List-ID: <devicetree.vger.kernel.org>
X-Mailing-List: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235019>

Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> writes:

>> diff --git a/arch/mips/boot/dts/include/dt-bindings b/arch/mips/boot/dts/include/dt-bindings
>> index 68ae388..08c00e4 120000
>> --- a/arch/mips/boot/dts/include/dt-bindings
>> +++ b/arch/mips/boot/dts/include/dt-bindings
>> @@ -1 +1 @@
>> -../../../../../include/dt-bindings
>> +../../../../../include/dt-bindings
>> \ No newline at end of file
>> -- 
>> 1.7.10.4
>
> I applied your patch - but now git-show shows it as an empty commit and
>
>   ls -lb arch/mips/boot/dts/include/dt-bindings
>
> still shows the \n at the end of the link target.
> ...
> So, I wonder if this is a git bug.

Sounds as if "git am" is losing the important bit of information
that new content ends with an incomplete line.

However, it does not reproduce for me.

    $ rm -fr /var/tmp/x && mkdir /var/tmp/x && cd /var/tmp/x
    $ git init
    $ ln -s 'a
    ' b
    $ git add b
    $ git commit -m initial
    $ ln -f -s a b
    $ git add b
    $ git commit -m fix
    $ git format-patch -1
    $ git checkout HEAD^
    $ git am 0001-*
    $ git diff HEAD^ HEAD
    diff --git a/b b/b
    index 7898192..2e65efe 120000
    --- a/b
    +++ b/b
    @@ -1 +1 @@
    -a
    +a
    \ No newline at end of file

I see the same with v1.7.10 (which may not match your version;
v1.7.10.4 is what was used by the patch submitter to prepare the
patch, and you did not say how you are applying the patches in your
message) and with more recent Git.  There is no such breakage.

I briefly suspected that you might be passing "--whitespace=fix" to
"am" and that may be incorrectly "fixing" the incomplete line, but
that is not the case.  I get the same result if I add the option to
"am" in the above transcript.

How are you applying the patch?  What is your Git version?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
