From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:12:35 -0800
Message-ID: <20130211071235.GL15329@elie.Belkin>
References: <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:13:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nZa-0006xB-NK
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab3BKHMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:12:44 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34624 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3BKHMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:12:43 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so570884pbc.31
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eGUitRxIa+zIFR319zM2CqdjJGSsNuz3mM7K4ZO2RmM=;
        b=plduY7/Wl69GY3xFtb4eRCxyZXFotQFS+PbcLwmxQvjd5JK6uQizNv2O5yZQiiTczH
         AwtP/r9tl8WR3WLnA8eDyAWjEh9aVvDLY4onYje/X7cJp79VXgI5xgJDUBJXBfZtTxzn
         yO/R7ltio7HZVtyHTxIZfIptyLW4JwCdD7vEacf7k0/6yW1Oh4GZEVpVUr9zSLYaR8El
         u5RE3qRSFzkzQOBzG/jpufpIs4voFwdRg/iL65xqJxGpfe1OnIsqkILDIoMrudfjmvz9
         9ctfETVS2ieTZ7lv+taxNFHXAlkrqco/yVNp4F7Zv6n8MBHb0dkdZ7/SxHLo6bubG2la
         kcPA==
X-Received: by 10.68.252.7 with SMTP id zo7mr16069963pbc.55.1360566762963;
        Sun, 10 Feb 2013 23:12:42 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id q1sm6783747pbb.6.2013.02.10.23.12.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 23:12:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vliavpc4q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216008>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The trouble is that I can't imagine a canned message that everyone
>> will like.  (For example, I quite dislike the current one.)  That's
>> exactly the situation in which some configurability is helpful.
>
> I am not saying we should have a perfect canned message everybody
> likes and not have any configurability.  I however think we can aim
> to come up with a message that covers 80% of site administrators who
> do not care too much and just want git-shell to allow the standard
> services without giving any custom command.

Isn't the current message meant to be that?  Just removing the "hint:"
line would be enough to leave me happy with it.

> And for the remaining 20% of those who do not like the canned
> message but still do not need any custom command, I think it is way
> suboptimal to force them to create git-shell-commands directory for
> 47 users his host gives git-shell access to, and copy the "help"
> script to all of them, only to get a customized message.

Isn't that a criticism of the git-shell-commands facility in general?
If it is common to have a lot of users with distinct home directories
but all with git-shell as their login shell, then the
git-shell-commands should not go in their home directory to begin
with, no?

I think sharing a home directory is fine and the normal thing to do
with such a restricted account, fwiw, so I am not the one to guess
what people who do something different would find most useful.  Maybe
I am not the right person to have proposed this patch in the first
place --- I saw something that looked wrong and proposed what I
thought was a reasonable fix, but I am not actively depending on
git-shell myself, so...

*shrug*

Hope that helps,
Jonathan
