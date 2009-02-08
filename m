From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Sun, 8 Feb 2009 11:43:45 +0000
Message-ID: <57518fd10902080343p47e30330ufdf2ece909ea0bd9@mail.gmail.com>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <7vr62ay8dh.fsf@gitster.siamese.dyndns.org>
	 <57518fd10902070401x14cc7cacrfb8bc88bbf2999cd@mail.gmail.com>
	 <498E3456.1080509@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:45:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW869-0000ZC-In
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZBHLnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbZBHLnt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:43:49 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:50143 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbZBHLns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:43:48 -0500
Received: by bwz5 with SMTP id 5so481865bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=6AHQJhbFzoyaeFPP9dVPmzYKhsIQP/4FpHnQixBVOIY=;
        b=wvvesUgZSLnXYH5DfYThJ0URWoKnmzluLjHXZxYz7/C0LF2OokuiwIjeJGymzs3NiX
         Md4+/rQUnii+JEC3ZKsP900VtYVv/5RSRj3EcClGJRk9VzhH9NZnHqn8S2LRjjjaoQXd
         7i48COny2MQgWQ/nnx/iKG7R90+rDJ5iVQ52E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CP1vJ8vn1o6srSOoxygIi/TX2EK7M3hf9liX+u9sJ30PfW7pjnnlRHNn3SrqTQkTuY
         QyLiCHbi0bxLzXqhRQ6ol14tsXSS6LCu79bQ78GRcqstazHpZts4NI/O21aC83Enxy0B
         u9N/aeDT7+Y8KI3SWnIFnax2YewC5jCSUjsm8=
Received: by 10.223.105.195 with SMTP id u3mr2739206fao.13.1234093425584; Sun, 
	08 Feb 2009 03:43:45 -0800 (PST)
In-Reply-To: <498E3456.1080509@hashpling.org>
X-Google-Sender-Auth: de96f0c60756af8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108963>

On 2/8/09, Charles Bailey <charles@hashpling.org> wrote:
> Jonathan del Strother wrote:
>> On Sat, Feb 7, 2009 at 8:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jonathan del Strother <jon.delStrother@bestbefore.tv> writes:
>>>
>>>> Add a "Show changes" option to each prompt in mergetool. This prints the
>>>> conflicted changes on the current file, using 'git log -p --merge
>>>> <file>'
>>> I think the patch should look like this, given the recent conversation I
>>> had with you.  It seems that the script thinks the unit of indentation is
>>> 4-places, and case arms are indented from case/esac (neither of which is
>>> the standard git shell script convention), and I tried to match that
>>> style
>>> used in the existing code.
>>>
>>> No, I didn't test it.
>>>
>>> Charles volunteered to take over mergetool, so he is on the Cc: list.
>
> At the moment, I'm slightly cool towards this patch, but perhaps I don't
>  really understand the underlying issue. I understand wanting to check
> something (logs) in the middle of a mergetool run but I can't say that
> I've ever wanted to specifically run 'git log -p --merge'. Perhaps some
> users of mergetool - being visual people - would more naturally reach
> for gitk?
>
> Given that mergetool picks up from where it left off when run a second
> time, what does this patch offer over Ctrl-c, run log tool of your
> choice, re-run mergetool? Or just running git log in a different
> terminal instance?
>

A large part of my motivation behind this patch was basically
education - my team (and myself) have made poor merge decisions in the
past, largely due to not being aware of a tool like "git log --merge".
The patch was attempting to get inexperienced users to make better use
of such tools. I certainly wouldn't be averse to using gitk instead.
