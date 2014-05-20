From: "Stewart, Louis (IS)" <louis.stewart@ngc.com>
Subject: RE: EXT :Re: GIT and large files
Date: Tue, 20 May 2014 18:18:08 +0000
Message-ID: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD670@XMBVAG73.northgrum.com>
References: <C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD53E@XMBVAG73.northgrum.com>
	<xmqqmwec1i9f.fsf@gitster.dls.corp.google.com>
	<C755E6FBF6DC4447BEF161CE48BDE0BD2F0CD631@XMBVAG73.northgrum.com>
 <xmqqoaysz59s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmodO-0005zA-UM
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbaETST1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:19:27 -0400
Received: from xspv0103.northgrum.com ([134.223.120.78]:37983 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaETST0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2014 14:19:26 -0400
Received: from XHTV0002.northgrum.com (unknown [134.223.80.11]) by xspv0103.northgrum.com with smtp
	(TLS: TLSv1/SSLv3,128bits,AES128-SHA)
	 id 4d95_3910_d760aeae_587e_43c9_92e8_2790f0fa69be;
	Tue, 20 May 2014 13:19:24 -0500
Received: from XHTVAG08.northgrum.com (134.223.82.85) by
 XHTV0002.northgrum.com (134.223.80.11) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 20 May 2014 13:18:08 -0500
Received: from XMBVAG73.northgrum.com ([169.254.4.90]) by
 XHTVAG08.northgrum.com ([134.223.82.85]) with mapi id 14.03.0174.001; Tue, 20
 May 2014 13:18:08 -0500
Thread-Topic: EXT :Re: GIT and large files
Thread-Index: AQHPdFddIRG4rEeQYkKWeW5LUnT0UZtJxlJQ
In-Reply-To: <xmqqoaysz59s.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.223.82.117]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249715>

>From you response then there is a method to only obtain the Project, Directory and Files (which could hold 80 GBs of data) and not the rest of the Repository that contained the full overall Projects?

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Tuesday, May 20, 2014 2:15 PM
To: Stewart, Louis (IS)
Cc: git@vger.kernel.org
Subject: Re: EXT :Re: GIT and large files

"Stewart, Louis (IS)" <louis.stewart@ngc.com> writes:

> Thanks for the reply.  I just read the intro to GIT and I am concerned 
> about the part that it will copy the whole repository to the 
> developers work area.  They really just need the one directory and 
> files under that one directory. The history has TBs of data.

Then you will spend time reading, processing and writing TBs of data when you clone, unless your developers do something to limit the history they fetch, e.g. by shallowly cloning.

>
> Lou
>
> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, May 20, 2014 1:18 PM
> To: Stewart, Louis (IS)
> Cc: git@vger.kernel.org
> Subject: EXT :Re: GIT and large files
>
> "Stewart, Louis (IS)" <louis.stewart@ngc.com> writes:
>
>> Can GIT handle versioning of large 20+ GB files in a directory?
>
> I think you can "git add" such files, push/fetch histories that contains such files over the wire, and "git checkout" such files, but naturally reading, processing and writing 20+GB would take some time.  In order to run operations that need to see the changes, e.g. "git log -p", a real content-level merge, etc., you would also need sufficient memory because we do things in-core.
