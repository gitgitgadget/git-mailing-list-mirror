From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 16:28:00 +0200
Message-ID: <81b0412b0809230728p4e81572bg67a3bec4c32c7dfb@mail.gmail.com>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>
	 <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
	 <48D8983C.7070506@op5.se>
	 <94c1db200809230054t20e7e61dh5022966d4112eee6@mail.gmail.com>
	 <48D8A97E.8070003@op5.se>
	 <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Mario Pareja" <mpareja.dev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8t8-0006Wy-1Z
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbYIWO2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYIWO2E
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:28:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:17471 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYIWO2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:28:01 -0400
Received: by yx-out-2324.google.com with SMTP id 8so316041yxm.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6QLuqJ2XW/Z7dYOMQrbDTFogg04Y6575rvWw9fkhl/s=;
        b=cXLoaDfJntDa/c3AwldJ2PLgeyudGDMlSG6RD3wJ7DgrgESsfDsES9YV57FZSweS58
         oTZbyzv5Rvl6s1w2AP4coK/ZbKBDo20mcF3PWOg8w/kKiv9VDydn8dsAAbRJV7FZOVq+
         vIapiXPWiGayeevNYFpIBmuoEKNKal2NQbUPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g6yUKzgqZbfcUR8YYNqQYy6inyQi6iQ0wIzcVCxeeyVTYEgX1fSpyDGh5EWZ197Tvc
         j78pWVNQOWwaqvV5uFg+PyUcBXk4oC9zUP7yYNILLNVpaRw3bD2kXWdgGBiZJ+cn7lPs
         0NLSCMH17f63GWMYYNwm+5CmQnMVzskYws9g0=
Received: by 10.151.143.3 with SMTP id v3mr9278862ybn.159.1222180080652;
        Tue, 23 Sep 2008 07:28:00 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Tue, 23 Sep 2008 07:28:00 -0700 (PDT)
In-Reply-To: <94c1db200809230656q4a9a765dw2354c0058b1d940c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96569>

2008/9/23 Mario Pareja <mpareja.dev@gmail.com>:
>> So it's a communication issue then.
>
> Yes, but I think the communication of this information needs to happen
> as part of a developers normal work-flow rather than requiring them to
> remember to check an external system.

Look at pre-receive and update hooks. They can deny a push operation and
get enough information to notice a change to the path of your unlucky file.

And yes, *you* have to do that yourself.
