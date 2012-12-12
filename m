From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 11 Dec 2012 22:15:13 -0700
Message-ID: <50C812E1.4020108@workspacewhiz.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com> <50B1F684.5020805@alum.mit.edu> <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com> <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com> <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com> <1355273635-ner-4863@calvin> <CACsJy8A9h4QJ_iWvQqTtYa4NPH6Q1Gy0NTozbgukC3=ep58mLA@mail.gmail.com> <CACh33FqTBOMar=V8=aiE2asZ_ri37fAqeghJLqGecYk=qtvBiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:15:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiefP-0007oW-9b
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 06:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878Ab2LLFPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 00:15:15 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33749 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2LLFPO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 00:15:14 -0500
Received: (qmail 28052 invoked by uid 399); 11 Dec 2012 22:15:11 -0700
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@76.23.33.208)
  by hsmail.qwknetllc.com with ESMTPAM; 11 Dec 2012 22:15:11 -0700
X-Originating-IP: 76.23.33.208
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CACh33FqTBOMar=V8=aiE2asZ_ri37fAqeghJLqGecYk=qtvBiQ@mail.gmail.com>
X-Antivirus: avast! (VPS 121211-1, 12/11/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211327>

----- Original Message -----
From: Patrick Donnelly
Date: 12/11/2012 7:26 PM
>> If we use lua for writing "builtin" commands,
>> we'll need to export a lot of C functions and writing wrappers like
>> this is boring and time consuming. Also, assume I export fn(char*,int)
>> to Lua, then I change the prototype to fn(char*, char*), can Lua spot
>> all the call sites at compile time (or something) so I can update
>> them?
> If the API calls are generic (don't require special handling), you can
> use some preprocessor magic to save time/space.
Since I mostly use C++, thanks to template metaprogramming, I get to 
register functions like so:

         void SomeExistingFunction(char* str, int num);

luaState->GetGlobals().RegisterDirect("SomeExistingFunction", 
SomeExistingFunction);

I certainly am not suggesting C++ be used within Git, but in this case, 
C++ has some nice compile-time advantages.

:)

-Josh
