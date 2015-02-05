From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] cpu: add device_add foo-x86_64-cpu support
Date: Thu, 05 Feb 2015 12:17:15 -0800
Message-ID: <xmqq61bgkt9w.fsf@gitster.dls.corp.google.com>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
	<20150205114914.GA10126@stefanha-thinkpad.redhat.com>
	<54D38B73.4060803@redhat.com>
	<xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
	<20150205195758.GC15326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Blake <eblake@redhat.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
	tangchen@cn.fujitsu.com, chen.fan.fnst@cn.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com,
	guz.fnst@cn.fujitsu.com, anshul.makkar@profitbricks.com,
	afaerber@suse.de, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:17:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSrb-0000LU-TA
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbBEURT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:17:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751151AbbBEURS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:17:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7928D35891;
	Thu,  5 Feb 2015 15:17:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pjfvfEUXQBsvboJ/qwGcT5DgxU4=; b=k9hCd9
	Pv22lWCUsmSHNYXGjyipy9Fp8j4/jxaSQnkQZ6pPU4qmsaVMMG1K0pCXKKZnZS8n
	BizhyoGGCWn05kAGzPn5jT9tf7fuft/VpDRLuZy3HMxshY3iZzbvuLBJVxY1sLvB
	Q+FulTJSfPUsMgY9dpqzSLOzmqJ54IS/ysvvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KC/CIZvdyPLVCz8xR2T/kEbsnuRpL6gk
	nN7yHIjZ/tdpGTtEALxkP/wY8DJkKCHuouNvNUjH6bvM22Mmr3UF0zqhTessJpxM
	+yxQx0KVjTcKZiB0DbjvfJ+Z+lJNc+267d6DhievXmmYRZbiuIK46rrVrxyt8yLn
	ULM8esVhLMg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D9663588D;
	Thu,  5 Feb 2015 15:17:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDD1C3588A;
	Thu,  5 Feb 2015 15:17:16 -0500 (EST)
In-Reply-To: <20150205195758.GC15326@peff.net> (Jeff King's message of "Thu, 5
	Feb 2015 14:57:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FAD7E1DA-AD73-11E4-B917-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263398>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 05, 2015 at 11:29:07AM -0800, Junio C Hamano wrote:
>
>> Eric Blake <eblake@redhat.com> writes:
>> 
>> > On 02/05/2015 04:49 AM, Stefan Hajnoczi wrote:
>> >> On Wed, Jan 14, 2015 at 03:27:23PM +0800, Zhu Guihua wrote:
>> >>> This series is based on the previous patchset from Chen Fan:
>> >>> https://lists.nongnu.org/archive/html/qemu-devel/2014-05/msg02360.html
>> >> 
>> >> This email has an invalid charset:
>> >> Content-Type: text/plain; charset="y"
>> >> 
>> >> I guess you entered "y" when asked how the message was encoded.
>> >> 
>> >> Please don't do that, it means we can only guess at the charset.
>> >
>> > In the past, people made a similar problem when 'git send-email' was
>> > asking if a message was in-reply-to something else (the number of
>> > messages incorrectly threaded to a message-id of 'y' or 'n' was evidence
>> > of the poor quality of the question).  git.git commit 51bbccfd1b4a
>> > corrected that problem.  Sounds like charset encoding is another case
>> > where the interactive parser should be taught to balk at nonsense
>> > encoding answers?
>> 
>> I think I answered this in $gmane/263354; care to come up with a
>> plausible valid_re?  It is inpractical to attempt to cover all valid
>> charset names, so whatever you do I'd imagine you would want to pass
>> the confirm_only parameter set to true.
>
> Would "length() > 1" be enough[1]? Or are people really typing "yes" and
> not just "y"?
>
> I cannot imagine a charset name that is smaller than two characters. It
> may be that there are none smaller than 4, and we could cut it off
> there. Googling around for some lists of common charsets, it seems like
> that might be plausible (but not any larger; "big5" is 4 characters, and
> people may spell "utf8" without the hyphen).
>
> -Peff
>
> [1] Of course, to match the existing regex code, we may want to spell
>     this as "/../" or "/..../".

Perhaps. Just in case there were shorter ones, something like this
with confirm_only to allow them to say "Yes, I do mean 'xx'"?

 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3092ab3..848f176 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -752,6 +752,7 @@ sub file_declares_8bit_cte {
 		print "    $f\n";
 	}
 	$auto_8bit_encoding = ask("Which 8bit encoding should I declare [UTF-8]? ",
+				  valid_re => qr/.{4}/, confirm_only => 1,
 				  default => "UTF-8");
 }
 
