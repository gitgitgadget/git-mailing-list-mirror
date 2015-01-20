From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 20 Jan 2015 16:40:52 +0000
Message-ID: <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDbre-00028W-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 17:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbbATQlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 11:41:04 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:40460 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbbATQlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 11:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4148; q=dns/txt; s=iport;
  t=1421772062; x=1422981662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J8+753XffbObUA2k0+6izuGtLpMYH1etcIOHhIUMZsU=;
  b=S6FmlaDFNYXG4RCTijMdfaYAho6/OTA9RzYvM+EQ8FaAKNY6WDqFT9Vs
   bPBEJllMhC+ZYnT6jU/SWZ2XoK0Enzb5tYB9IGhwnvGSGBMKI6RTztUpr
   r+xit+fnxce/ufA3SJM78LTXsbuqq2EcO7YKtHlCB7iAMuqzEYwUr28Nw
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ai0FALOEvlStJA2N/2dsb2JhbABbgwZSWASDA8khAhyBCEMBAQEBAX2EDAEBAQMBIwQNRQULAgEIGAICFBICAgIwFRACBA4FiCQIvGOTZAEBAQEBAQEBAQEBAQEBAQEBAQEBAReBIY4TEjMHGIJQLoETAQSOWYkXkioig25vgUV+AQEB
X-IronPort-AV: E=Sophos;i="5.09,435,1418083200"; 
   d="scan'208";a="385589806"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by rcdn-iport-1.cisco.com with ESMTP; 20 Jan 2015 16:40:53 +0000
Received: from xhc-rcd-x04.cisco.com (xhc-rcd-x04.cisco.com [173.37.183.78])
	by alln-core-8.cisco.com (8.14.5/8.14.5) with ESMTP id t0KGeqve017500
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 20 Jan 2015 16:40:52 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.219]) by
 xhc-rcd-x04.cisco.com ([fe80::200:5efe:173.37.183.34%12]) with mapi id
 14.03.0195.001; Tue, 20 Jan 2015 10:40:52 -0600
Thread-Topic: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Thread-Index: AQHQKtooFAV48lOUvEGHDNPe7JHDHZzJrpSA
In-Reply-To: <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.250.207]
Content-ID: <DD6F5CCD1E337B4F8106BA5B52A94F88@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262678>

SSBkaWQgbm90IHRlc3QgdGhpcyBwYXRjaC4gIElzIHRoYXQgaG9sZGluZyB1cCBhIGNvbW1pdD8N
CuKAlCANCkRhbiBMYW5naWxsZQ0KSW5mcmFzdHJ1Y3R1cmUgJiBPcGVyYXRpb25zDQpUYWxvcyBH
cm91cA0KU291cmNlZmlyZSwgSW5jLg0KDQo+IE9uIEphbiA3LCAyMDE1LCBhdCA3OjI5IFBNLCBi
cmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNydXN0eXRvb3RocGFzdGUubmV0PiB3cm90ZToNCj4g
DQo+IEFwYWNoZSBzZXJ2ZXJzIHVzaW5nIG1vZF9hdXRoX2tlcmIgY2FuIGJlIGNvbmZpZ3VyZWQg
dG8gYWxsb3cgdGhlIHVzZXINCj4gdG8gYXV0aGVudGljYXRlIGVpdGhlciB1c2luZyBOZWdvdGlh
dGUgKHVzaW5nIHRoZSBLZXJiZXJvcyB0aWNrZXQpIG9yDQo+IEJhc2ljIGF1dGhlbnRpY2F0aW9u
ICh1c2luZyB0aGUgS2VyYmVyb3MgcGFzc3dvcmQpLiAgT2Z0ZW4sIG9uZSB3aWxsDQo+IHdhbnQg
dG8gdXNlIE5lZ290aWF0ZSBhdXRoZW50aWNhdGlvbiBpZiBpdCBpcyBhdmFpbGFibGUsIGJ1dCBm
YWxsIGJhY2sNCj4gdG8gQmFzaWMgYXV0aGVudGljYXRpb24gaWYgdGhlIHRpY2tldCBpcyBtaXNz
aW5nIG9yIGV4cGlyZWQuDQo+IA0KPiBIb3dldmVyLCBsaWJjdXJsIHdpbGwgdHJ5IHZlcnkgaGFy
ZCB0byB1c2Ugc29tZXRoaW5nIG90aGVyIHRoYW4gQmFzaWMNCj4gYXV0aCwgZXZlbiBvdmVyIEhU
VFBTLiAgSWYgQmFzaWMgYW5kIHNvbWV0aGluZyBlbHNlIGFyZSBvZmZlcmVkLCBsaWJjdXJsDQo+
IHdpbGwgbmV2ZXIgYXR0ZW1wdCB0byB1c2UgQmFzaWMsIGV2ZW4gaWYgdGhlIG90aGVyIG9wdGlv
biBmYWlscy4NCj4gVGVhY2ggdGhlIEhUVFAgY2xpZW50IGNvZGUgdG8gc3RvcCB0cnlpbmcgYXV0
aGVudGljYXRpb24gbWVjaGFuaXNtcyB0aGF0DQo+IGRvbid0IHVzZSBhIHBhc3N3b3JkIChjdXJy
ZW50bHkgTmVnb3RpYXRlKSBhZnRlciB0aGUgZmlyc3QgZmFpbHVyZSwNCj4gc2luY2UgaWYgdGhl
eSBmYWlsZWQgdGhlIGZpcnN0IHRpbWUsIHRoZXkgd2lsbCBuZXZlciBzdWNjZWVkLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3Rl
Lm5ldD4NCj4gU2lnbmVkLW9mZi1ieTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KPiAtLS0N
Cj4gUGVmZidzIG9yaWdpbmFsIGNoYW5nZSB3YXMgdG8gZ2V0X2N1cmxfaGFuZGxlOyBob3dldmVy
LCB3ZSByZXRyeSB0aGUNCj4gc2Vjb25kIHRpbWUgd2l0aCB0aGUgc2FtZSBzbG90IGFuZCB3ZSBt
YXkgbm90IGNhbGwgZ2V0X2N1cmxfaGFuZGxlDQo+IGFnYWluLCBzbyBJIGhhZCB0byBtb3ZlIHRo
YXQgY2hhbmdlIHRvIGdldF9hY3RpdmVfc2xvdC4gIFRoaXMgaGFzIGJlZW4NCj4gdGVzdGVkIHB1
c2hpbmcgd2l0aCBib3RoIE5lZ290aWF0ZSBhbmQgQmFzaWMgYWdhaW5zdCBhbiBIVFRQUyBzZXJ2
ZXINCj4gYm90aCB3aGVuIGluZm8vcmVmcyB3YXMgcHJvdGVjdGVkIGFuZCB3aGVuIGl0IHdhcyBu
b3QuDQo+IA0KPiBodHRwLmMgfCAxMCArKysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHR0cC5jIGIvaHR0cC5jDQo+IGluZGV4
IDA0MGYzNjIuLjQ0YjEzMGMgMTAwNjQ0DQo+IC0tLSBhL2h0dHAuYw0KPiArKysgYi9odHRwLmMN
Cj4gQEAgLTYyLDYgKzYyLDkgQEAgc3RhdGljIGNvbnN0IGNoYXIgKnVzZXJfYWdlbnQ7DQo+IA0K
PiBzdGF0aWMgc3RydWN0IGNyZWRlbnRpYWwgY2VydF9hdXRoID0gQ1JFREVOVElBTF9JTklUOw0K
PiBzdGF0aWMgaW50IHNzbF9jZXJ0X3Bhc3N3b3JkX3JlcXVpcmVkOw0KPiArI2lmZGVmIExJQkNV
UkxfQ0FOX0hBTkRMRV9BVVRIX0FOWQ0KPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgaHR0cF9hdXRo
X21ldGhvZHMgPSBDVVJMQVVUSF9BTlk7DQo+ICsjZW5kaWYNCj4gDQo+IHN0YXRpYyBzdHJ1Y3Qg
Y3VybF9zbGlzdCAqcHJhZ21hX2hlYWRlcjsNCj4gc3RhdGljIHN0cnVjdCBjdXJsX3NsaXN0ICpu
b19wcmFnbWFfaGVhZGVyOw0KPiBAQCAtNTgwLDYgKzU4Myw5IEBAIHN0cnVjdCBhY3RpdmVfcmVx
dWVzdF9zbG90ICpnZXRfYWN0aXZlX3Nsb3Qodm9pZCkNCj4gCWN1cmxfZWFzeV9zZXRvcHQoc2xv
dC0+Y3VybCwgQ1VSTE9QVF9VUExPQUQsIDApOw0KPiAJY3VybF9lYXN5X3NldG9wdChzbG90LT5j
dXJsLCBDVVJMT1BUX0hUVFBHRVQsIDEpOw0KPiAJY3VybF9lYXN5X3NldG9wdChzbG90LT5jdXJs
LCBDVVJMT1BUX0ZBSUxPTkVSUk9SLCAxKTsNCj4gKyNpZmRlZiBMSUJDVVJMX0NBTl9IQU5ETEVf
QVVUSF9BTlkNCj4gKwljdXJsX2Vhc3lfc2V0b3B0KHNsb3QtPmN1cmwsIENVUkxPUFRfSFRUUEFV
VEgsIGh0dHBfYXV0aF9tZXRob2RzKTsNCj4gKyNlbmRpZg0KPiAJaWYgKGh0dHBfYXV0aC5wYXNz
d29yZCkNCj4gCQlpbml0X2N1cmxfaHR0cF9hdXRoKHNsb3QtPmN1cmwpOw0KPiANCj4gQEAgLTg3
MCw2ICs4NzYsOSBAQCBpbnQgaGFuZGxlX2N1cmxfcmVzdWx0KHN0cnVjdCBzbG90X3Jlc3VsdHMg
KnJlc3VsdHMpDQo+IAkJCWNyZWRlbnRpYWxfcmVqZWN0KCZodHRwX2F1dGgpOw0KPiAJCQlyZXR1
cm4gSFRUUF9OT0FVVEg7DQo+IAkJfSBlbHNlIHsNCj4gKyNpZmRlZiBMSUJDVVJMX0NBTl9IQU5E
TEVfQVVUSF9BTlkNCj4gKwkJCWh0dHBfYXV0aF9tZXRob2RzICY9IH5DVVJMQVVUSF9HU1NORUdP
VElBVEU7DQo+ICsjZW5kaWYNCj4gCQkJcmV0dXJuIEhUVFBfUkVBVVRIOw0KPiAJCX0NCj4gCX0g
ZWxzZSB7DQo+IEBAIC05ODYsNiArOTk1LDcgQEAgc3RhdGljIHZvaWQgZXh0cmFjdF9jb250ZW50
X3R5cGUoc3RydWN0IHN0cmJ1ZiAqcmF3LCBzdHJ1Y3Qgc3RyYnVmICp0eXBlLA0KPiAJCXN0cmJ1
Zl9hZGRzdHIoY2hhcnNldCwgIklTTy04ODU5LTEiKTsNCj4gfQ0KPiANCj4gKw0KPiAvKiBodHRw
X3JlcXVlc3QoKSB0YXJnZXRzICovDQo+ICNkZWZpbmUgSFRUUF9SRVFVRVNUX1NUUkJVRgkwDQo+
ICNkZWZpbmUgSFRUUF9SRVFVRVNUX0ZJTEUJMQ0KPiAtLSANCj4gMi4yLjEuMjA5Lmc0MWU1ZjNh
DQo+IA0KDQo=
