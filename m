From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Thu, 12 Mar 2015 13:09:40 +0000
Message-ID: <6A7DB00C-7787-41A0-9C9F-88F6CFD92D98@cisco.com>
References: <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
 <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
 <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
 <E53D99DB-E894-4FA8-9351-39E23FFD677E@cisco.com>
 <20150310222907.GA36141@vauxhall.crustytoothpaste.net>
 <68DFACB3-5EA7-4414-9B74-B4E6F6A417B9@cisco.com>
 <20150311215919.GA46326@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 14:10:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW2sC-00046K-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 14:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbbCLNJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 09:09:43 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:28432 "EHLO
	alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbbCLNJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 09:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1508; q=dns/txt; s=iport;
  t=1426165782; x=1427375382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1wMQmUZJ74hFG/6b8vfTQU5QLeeX8XRQ3FgqW9GrjkA=;
  b=N6xqHATEqIuipfr1C4t4mCMPSGhB8Uo7z6OAvV4yW4PKhuhA2QAe8WQs
   SHMj5U7xq3ahWOi+Rz/tuPnWcHq93e8OMFeam4idZk7Qg5FVQESBjVzFQ
   mMMztt2l5/nxLpxUFOM9Yqm533IRDepDt/76YMwKtMtaLdyBy4Qtp38EN
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A0A3CABSjwFV/4kNJK1bgwZSWgSDB7pGhX+FcAIcgRNMAQEBAQEBfYQPAQEBAwEjEUUFCwIBCBgCAiYCAgIwFRACBA4FiCcIDbAKmwkBAQEBAQEBAQEBAQEBAQEBAQEBAQETBIEhiXaCYYFLEjMHgmgvgRYFkCSDaIV5gRqPHoNFI4NubwGBQ38BAQE
X-IronPort-AV: E=Sophos;i="5.11,388,1422921600"; 
   d="scan'208";a="131310457"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-1.cisco.com with ESMTP; 12 Mar 2015 13:09:41 +0000
Received: from xhc-rcd-x07.cisco.com (xhc-rcd-x07.cisco.com [173.37.183.81])
	by alln-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id t2CD9fd7026844
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 12 Mar 2015 13:09:41 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.151]) by
 xhc-rcd-x07.cisco.com ([173.37.183.81]) with mapi id 14.03.0195.001; Thu, 12
 Mar 2015 08:09:41 -0500
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQSwqcFAV48lOUvEGHDNPe7JHDHZz2+1uAgAHaeICAB+NbAIABkSyAgBQtCoCAAEmXAIABYSQAgAAo3QCAAP5agA==
In-Reply-To: <20150311215919.GA46326@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.100.213.182]
Content-ID: <F01DFA77F007324EB11CE6F75DE89088@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265362>

PiBPbiBNYXIgMTEsIDIwMTUsIGF0IDU6NTkgUE0sIGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNA
Y3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBNYXIgMTEsIDIwMTUg
YXQgMDc6MzM6MDVQTSArMDAwMCwgRGFuIExhbmdpbGxlIChkYWxhbmdpbCkgd3JvdGU6DQo+Pj4g
T24gTWFyIDEwLCAyMDE1LCBhdCA2OjI5IFBNLCBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNy
dXN0eXRvb3RocGFzdGUubmV0PiB3cm90ZToNCj4+PiBEb2VzIGl0IHdvcmsgd2l0aCBhIHRpY2tl
dCBpZiB5b3Ugc3BlY2lmeSBhIHVzZXJuYW1lLCBhcyBpbiB0aGUNCj4+PiBmb2xsb3dpbmcgVVJM
Pw0KPj4+IGh0dHBzOi8vYm1jQGdpdC5jcnVzdHl0b290aHBhc3RlLm5ldC9naXQvYm1jL2hvbWVk
aXIuZ2l0DQo+PiANCj4+IFllcywgdGhhdCBkb2VzIHdvcmsuICBPdXIgcHJvamVjdCBpcyA5OCUg
b2YgdGhlIHdheSB0aGVyZSBub3cuDQo+PiANCj4+IEkgbG9va2VkIGF0IGJvdGggbGliY3VybCBh
bmQgZ2l0IGVudmlyb25tZW50IHZhcmlhYmxlcyB0byBzZWUgaWYgdGhlcmUNCj4+IHdhcyBhIHdh
eSB0byBzcGVjaWZ5IHRoZSB1c2VyIHdpdGhvdXQgcHV0dGluZyBpdCBpbiB0aGUgVVJMLiAgSSBk
aWRu4oCZdCBzZWUgb25lLg0KPj4gDQo+PiBNeSBuZXh0IHN0ZXAgaXMgdGhlIGdpdCBjb25maWd1
cmF0aW9uLCBlaXRoZXIgc2VydmVyIG9yIGNsaWVudC4gIERvIHlvdSBrbm93DQo+PiBpZiBJIHNo
b3VsZCBzdG9wIGxvb2tpbmcgbm93IGJlY2F1c2UgaXTigJlzIG5vdCB0aGVyZT8NCj4gDQo+IFlv
dSBtaWdodCB0cnkgbG9va2luZyBhdCBnaXQgY29uZmlnIC0taGVscC4gIEl0IGxvb2tzIGxpa2Ug
dGhlcmUncyBhDQo+IGNyZWRlbnRpYWwudXNlcm5hbWUgb3B0aW9uIHRoYXQgbWlnaHQgZG8gd2hh
dCB5b3Ugd2FudC4NCg0KQnJpYW4gZXQgYWwsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBoZWxwIGFu
ZCBwYXRpZW5jZSB3aXRoIHRoaXMuICBJdCBpcyBhcHByZWNpYXRlZC4NCg0K4oCUIA0KRGFuIExh
bmdpbGxlDQpJbmZyYXN0cnVjdHVyZSAmIE9wZXJhdGlvbnMNClRhbG9zIEdyb3VwDQpTb3VyY2Vm
aXJlLCBJbmMuDQoNCg0KDQo=
