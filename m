From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/13] revert: Propogate errors upwards from
 do_pick_commit
Date: Tue, 21 Jun 2011 14:32:17 -0500
Message-ID: <20110621193217.GA17390@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-5-git-send-email-artagnon@gmail.com>
 <20110621162232.GI15461@elie>
 <7viprz8018.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ6ga-0005Bw-OX
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab1FUTc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:32:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43032 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab1FUTc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:32:26 -0400
Received: by iyb12 with SMTP id 12so78033iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Dz1LVScVQIlK+UdlWnSXpnxEt2cEhZ8vRtSByhbwF0E=;
        b=bJFq86/LSM9+jBAfZuS82fi8PadI3kZuTs2ndxKuL6YaEaTfUFZi9pTmr/sGUo2B5A
         Ri7zCkm7IJ+86wdF8WjM2w6+aa+4DMe+ZIPMZPxwWH8OP6HYzL+39wgsvoRlyNMmpDbA
         0J88dhxcDlAb0oRp5+bJd6nDqXyMfqSHWXqGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NQ6vcaWWTgo0Rsi7skyuvnjfN2KGkKseRPqv7OCnE+olvFUWP8AuMk19jfjZthdcGu
         d/So78uxR/7Qrg6OmgNB3+FzYc0TeqzWrX/3BT27DT4VPqpGbXkUI5TIFY2J+bQTqoEn
         1tII7md7IMo/WRc8fvg+wdphHpnayoNcn2al8=
Received: by 10.42.75.67 with SMTP id z3mr7832802icj.208.1308684745658;
        Tue, 21 Jun 2011 12:32:25 -0700 (PDT)
Received: from elie ([69.209.79.158])
        by mx.google.com with ESMTPS id ly7sm7039639icb.12.2011.06.21.12.32.23
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 12:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viprz8018.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176187>

Jun 21, 2011 at 12:19:47PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> +	if (res < 0)
>>> +		die(_("%s failed"), me);
>>> +	return 0;
>>
>> Should the "revert" or "cherry-pick" here be part of the message
>> marked for translation?  A translator might want to paraphrase to
>>
>> 	fatal: failed to cherry-pick
>>
>> if that is more natural in the language at hand.
>
> Wouldn't such a message file simply say
>
> 	msgid "%s failed"
>         msgstr "failed to %s"
>
> IOW, I am not sure what problem you are seeing.

Ah, sorry for the lack of clarity.  What I meant is that the noun
and verb will be different words in many languages.  There can also be
problems of subject/verb agreement.  Also "me" is used elsewhere to
hold the command name as typed on the command line even when LANG
points to a language other than English if I remember correctly.

If the message were in revert_or_cherry_pick instead of having two
identical copies in cmd_revert and cmd_cherry_pick, it would have been
less striking (but still a potential problem).
