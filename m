From: Wincent Colaiuta <win@wincent.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 11:34:48 +0100
Message-ID: <6D3239B9-FFE2-48AB-A127-E394D2FC8130@wincent.com>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFS6Y-0002MO-UX
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 11:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbYAQKfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 05:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbYAQKfR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 05:35:17 -0500
Received: from wincent.com ([72.3.236.74]:35471 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518AbYAQKfO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 05:35:14 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HAYoSw018566;
	Thu, 17 Jan 2008 04:34:51 -0600
In-Reply-To: <478EEAC4.2010006@talkingspider.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70843>

El 17/1/2008, a las 6:42, Mike escribi=F3:

> Linus Torvalds wrote:
>
>> Some people don't split this up, and they tend to make horrible =20
>> horrible mistakes, like checking in the *results* of the post-=20
>> processing too (ie binary result blobs that can be regenerated from =
=20
>> the other files), because they don't make a clear separation =20
>> between the parts they do development on, and the end result.
>
> Honestly, I think your mode of thinking is centered around compiled =20
> languages and linux app(/kernel) development.  The web app =20
> development/deployment model is very different.
>
> With PHP, Python, and Ruby, the development is the deployment.  The =20
> source is the output.  You can't develop web apps in those languages =
=20
> unless the source files you're working on are under the doc root of =20
> your development server.   "the parts they do development on" and =20
> "the end result" *are* the same files.
>
> The "development server -> staging server -> live
> server" model has been around in common use for as long as web
> applications have. In fact, the term "deployment" falls apart here. =20
> From my web app developer perspective, the deployment is what lands =20
> on the live server.  For your git perspective, the "deployment" may =20
> mean the .../docroot/php directory for the development server (where =
=20
> our app code lives).

I don't think so. Most people I speak with doing web app development =20
develop locally and deploy remotely.

> There's a fundamental "best practice" of web development being =20
> violated here- keep your docroots clean, only put stuff in them that =
=20
> should go live (or should eventually go live when ready).  Other =20
> files should not live under docroot.

Assuming you're using Apache, why don't you just add an .htaccess file =
=20
to your repo at the top level which instructs Apache to forbid all =20
access to .git and its contents? If Apache is so broken that you can't =
=20
trust Apache to forbid access in those circumstances, then you can't =20
trust it to not allow access to arbitrary paths on your filesystem =20
outside of your doc root anyway.

Cheers,
Wincent
