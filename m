From: hpa@zytor.com
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 12:45:00 -0800 (PST)
Message-ID: <2198.69.104.58.50.1169671500.squirrel@www.zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
    <45B7818F.6020805@zytor.com> <200701242140.07459.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ozb-0007hn-Nn
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbXAXUpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 15:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbXAXUpK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:45:10 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48617 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbXAXUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:45:08 -0500
Received: from terminus.zytor.com (apache@localhost [127.0.0.1])
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0OKj00o013658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jan 2007 12:45:00 -0800
Received: (from apache@localhost)
	by terminus.zytor.com (8.13.8/8.13.8/Submit) id l0OKj0XV013657;
	Wed, 24 Jan 2007 12:45:00 -0800
X-Authentication-Warning: terminus.zytor.com: apache set sender to hpa@zytor.com using -f
Received: from 69.104.58.50
        (SquirrelMail authenticated user hpa)
        by www.zytor.com with HTTP;
        Wed, 24 Jan 2007 12:45:00 -0800 (PST)
In-Reply-To: <200701242140.07459.jnareb@gmail.com>
User-Agent: SquirrelMail/1.4.8-1.fc5
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-3.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	NO_REAL_NAME,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37679>

> H. Peter Anvin wrote:
>
>>> Besides, we can't rely that .git/info/refs is up to date, or even
>>> exists.
>>> It is for dumb protocols, not for gitweb.
>>
>> Well, SOMETHING needs to be done for this page, since it can take 15
>> minutes or more to generate.  Caching doesn't help one iota, since it's
>> stale before being generated.
>
> The simple and fast solution would be to make post-update hook contain
> the git-for-each-ref with parameters like in git_get_last_activity,
> saving e.g. to .git/info/last-committer, and in gitweb read this file
> if it exist, run git-for-each-ref otherwise (similar to what we used to
> do with .git/info/refs and git-peek-remote in gitweb).
>

Right, this is basically what I'm saying; the question is only whether or
not this fits into .git/info/refs or should be a separate file.

Either way, I think git-update-server-info should generate all these files.

    -hpa
