From: david@lang.hm
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Thu, 14 Apr 2011 18:56:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104141854210.13309@asgard.lang.hm>
References: <201102142039.59416.jnareb@gmail.com> <201104141154.55078.jnareb@gmail.com> <BANLkTik1dZ-_DGmj70=-+9j0EsUQZ=BbaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1365741227-1302832584=:13309"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: =?ISO-8859-2?Q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 03:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYH6-0002Wo-4R
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 03:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab1DOB4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 21:56:38 -0400
Received: from mail.lang.hm ([64.81.33.126]:38290 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092Ab1DOB4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 21:56:38 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p3F1uOJQ015777;
	Thu, 14 Apr 2011 18:56:24 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <BANLkTik1dZ-_DGmj70=-+9j0EsUQZ=BbaQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171575>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1365741227-1302832584=:13309
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 14 Apr 2011, Micha? ?owicki wrote:

> 2011/4/14 Jakub Narebski <jnareb@gmail.com>:
>>
>> Second issue is how to use it / how to include it:
>>
>> * Use some external Content Delivery Network (CDN), like
>>  Google Libraries API
>>     http://code.google.com/apis/libraries/devguide.html
>>  e.g.:
>>
>>  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
>>  <script src="http://code.jquery.com/jquery-1.5.2.min.js"></script>
>>
>>  or
>>
>>  <script src="https://ajax.googleapis.com/ajax/libs/mootools/1.3.1/mootools-yui-compressed.js"></script>
>>
>>  This is nice solution... if we don't need plugin / extension
>>  which usually are not available in CDN version of library.
>>
>>  Also this makes gitweb dependent on third-party service, and require
>>  network connectivity to Internet to have access to JavaScript-based
>>  features.
>>
>> * Mark appropriate JavaScript library as dependency in gitweb/INSTALL
>>  to be downloaded in appropriate place but do not provide sources.
>>  Perhaps add target in gitweb/Makefile that automatically downloads
>>  it.
>>
>>  This would make installing gitweb correctly more complicated.
>>  JavaScript-based features would not work if somebody instals gitweb
>>  incorrectly.
>>
>>  I think we can set up gitweb build so that one can configure at
>>  build stage whether to use CDN or download library, or use
>>  pre-downloaded (and perhaps instaled somewhere) version of framework
>>  (combining JavaScript on build in all but first case).
>
> I'm not sure about pre-downloaded version of libs. Most of the time
> it's not a big deal but sometimes it may introduce hard to detect
> issues when someone use different version of the lib -
> http://ejohn.org/blog/learning-from-twitter/ .But the idea with
> options - CDN or download is very good. CDNs can improve the page
> download speed by increasing simultaneous connections if files are
> downloaded from many hostnames but for companies where instances of
> gitweb are on the Intrantet the 2nd option could be better I think (at
> least in my case). Additionaly CDNs can save some money when you pay
> for data traffic :)

another advantage of using the library from a CDN is that the user may 
already have it cached in their browser and not have to download it at 
all.

as long as there is a build-time option to make a version that does not 
depend on being able to get to the Internet I think it's a good idea to 
make the default use the Internet.

David Lang
--680960-1365741227-1302832584=:13309--
