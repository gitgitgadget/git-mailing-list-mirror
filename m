From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: git show stash
Date: Wed, 12 Dec 2007 17:02:03 +0900
Message-ID: <200712120802.lBC82YDQ008276@mi1.bluebottle.com>
References: <20071212072836.GA10961@glandium.org> <20071212073728.GA12058@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2MYW-0001Sg-Vp
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbXLLICf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbXLLICf
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:02:35 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:33024 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbXLLICe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:02:34 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBC82YDQ008276
	for <git@vger.kernel.org>; Wed, 12 Dec 2007 00:02:34 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=KbdK6k1UnJeQ4PXla6RCKHxS1ojXBCP3BOtw0eSSYl3NgOTd+mvDxqEMjwyVszp4P
	J4MTo2W7jJKKXYyD98toWyJiqeGC8aLbiaSLawehYEo2G4bLjWXCs8d+EhC/oNN
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBC82Ofu002235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2007 00:02:32 -0800
In-Reply-To: <20071212073728.GA12058@glandium.org>
X-Trusted-Delivery: <879c83f2d41a58cec9ac6897e38313aa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68006>

Quoting Mike Hommey <mh@glandium.org>:

> On Wed, Dec 12, 2007 at 08:28:36AM +0100, Mike Hommey wrote:
>> Hi,
>> 
>> Is there a particular reason why git show stash displays 2 signs at the
>> beginning of changed lines, contrary to git show anyotherref that shows
>> only one ? (the diff header is also different)
>
> I got a hint by opening my eyes: the stash is a merge commit (why is
> that so, by the way ?).

Because it needs to record changes between your HEAD and your index, and changes between your HEAD and your working files.

              .-----STASH
             /     /
        HEAD ---INDEX

A stash is a merge between your HEAD (first parent) and a commit that records your index state (second parent).  The latter commit is a child of your HEAD.  If you never run "git add" and always commit with "git commit -a", it is most likely that "git stash show -p" will show two plus signs or minus signs and nothing else, but if you use "git add" to add your changes incrementally to your index you will see the difference.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
