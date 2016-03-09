From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: libcurl dependency for implementing RFC3161 timestamps
Date: Wed, 9 Mar 2016 08:04:10 -0500
Message-ID: <001a01d17a04$2fb1bbd0$8f153370$@nexbridge.com>
References: <e57d18f6010c0b581b38a3daef145221.squirrel@faumail.uni-erlangen.de> <59de05c280143e7dd3ead6139df7a525.squirrel@faumail.uni-erlangen.de> <CACsJy8BNNQFP3LHxH06KewUjUVc1eox1mQPsg8b=acq-M=mHNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Git Mailing List'" <git@vger.kernel.org>, <i4passt@cs.fau.de>,
	<phillip.raffeck@fau.de>
To: "'Duy Nguyen'" <pclouds@gmail.com>,
	"'Anton Wuerfel'" <anton.wuerfel@fau.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 14:04:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1addnE-0007BR-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 14:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbcCINEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 08:04:40 -0500
Received: from elephants.elehost.com ([216.66.27.132]:42779 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbcCINEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 08:04:38 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u29D4IEY075973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Mar 2016 08:04:19 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CACsJy8BNNQFP3LHxH06KewUjUVc1eox1mQPsg8b=acq-M=mHNQ@mail.gmail.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK2gjh1+8AP+dIgOgDEbcD0mOgAjAJ6GI7/AouvIvadXtPWoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288483>

On March 9, 2016 6:41 AM, Duy Nguyen wrote:
> To: Anton Wuerfel <anton.wuerfel@fau.de>
> Cc: Git Mailing List <git@vger.kernel.org>; i4passt@cs.fau.de;
> phillip.raffeck@fau.de
> Subject: Re: libcurl dependency for implementing RFC3161 timestamps
> 
> On Wed, Mar 9, 2016 at 6:24 PM, Anton Wuerfel <anton.wuerfel@fau.de>
> wrote:
> > -As git tag is a builtin part of the main git executable, introduce a
> > libcurl dependency for the main executable (maybe not best-practice).
> 
> libcurl was part of the main executable and then split out because it
> increased startup time [1]. I don't know if it's still true nowadays, maybe you
> should do a simple test before deciding to go that way.

The NSE NonStop port observed that at 2.7.3 (admittedly old) that libcurl was not used for local operations including status, log, reset, etc., but was needed for push, pull, fetch (a.k.a. network) operations. The libcurl.so is loaded statically at start-up for any components needing the latter operations. Added it for local processing is not going to help performance :(, which is quite bad enough on our platform.

Sincerely,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
