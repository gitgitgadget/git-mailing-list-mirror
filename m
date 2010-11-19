From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
Date: Fri, 19 Nov 2010 13:05:08 +0100
Message-ID: <AANLkTi=Ccc3AWQaFQdkCA=2Y5RJY7dE-6JFJ0vnpnjvf@mail.gmail.com>
References: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
	<1289899618-2845-1-git-send-email-bert.wesarg@googlemail.com>
	<87fwuxh75m.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: "Shawn O . Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:05:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPiS-0007CL-9B
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab0KSMFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:05:11 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46882 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543Ab0KSMFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:05:10 -0500
Received: by iwn35 with SMTP id 35so4756733iwn.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ymukIgGASVr25lpdol7XYSy4MC41cDAudEnAkbzUMJM=;
        b=kEFWKayhjUgwTYXkiEnxO9SU9OJFbY6HZ7P0osKcdTDOsXEbdjPB9HzL2Y9yw6sN6V
         3jXbqtVzQVIa2RoElYJbTk2B58uaxMSWOFB8Lu6FrQUExAHeo2gcsIigQ6AZEVi3yc3D
         jVOyrMPLrM+sQlbcT5GiZNU0m0QWDfLEdNH9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rm28LP0b35ti/rDBDSOiGlisgFTs0V/cO4sM3qy0nKGgcP9oz7iv+0vpAMwwgthGPr
         w5MDAwjVeZKLu4hWZQUi8CGeJl+iYUYDvSSc2Wcx12tpy/I6TfjiuvKR80t6NtVQh5nN
         Sgedconp049OVKPC2U03z9Zs6DvGGGWuN4xcQ=
Received: by 10.42.210.71 with SMTP id gj7mr1471804icb.307.1290168308252; Fri,
 19 Nov 2010 04:05:08 -0800 (PST)
Received: by 10.42.14.70 with HTTP; Fri, 19 Nov 2010 04:05:08 -0800 (PST)
In-Reply-To: <87fwuxh75m.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161741>

T24gRnJpLCBOb3YgMTksIDIwMTAgYXQgMTI6NDEsIFBhdCBUaG95dHMKPHBhdHRob3l0c0B1c2Vy
cy5zb3VyY2Vmb3JnZS5uZXQ+IHdyb3RlOgo+IEJlcnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bnb29n
bGVtYWlsLmNvbT4gd3JpdGVzOgo+Cj4+VGhpcyBhZGRzIGhpZ2hsaWdodCBzdXBwb3J0IGZvciB0
aGUgZGlmZjMgY29uZmxpY3Qgc3R5bGUuCj4+Cj4+VGhlIGNvbW1vbiBwcmUtaW1hZ2Ugd2lsbCBi
ZSByZXZlcnNlZCB0byAtLSwgYmVjYXVzZSBpdCBoYXMgYmVlbiByZW1vdmVkCj4+YW5kIGVpdGhl
ciByZXBsYWNlZCB3aXRoIG91ciBvciB0aGVpciBzaWRlLgo+Pgo+PlNpZ25lZC1vZmYtYnk6IEJl
cnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bnb29nbGVtYWlsLmNvbT4KPj4KPj4tLS0KPj4gZ2l0LWd1
aS9naXQtZ3VpLnNoIMKgIHwgwqAgwqAzICsrKwo+PiBnaXQtZ3VpL2xpYi9kaWZmLnRjbCB8IMKg
IDEwICsrKysrKysrKysKPj4gMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9naXQtZ3VpL2dpdC1ndWkuc2ggYi9naXQtZ3Vp
L2dpdC1ndWkuc2gKPj5pbmRleCAzODM2MmZhLi4wMTM0NDM4IDEwMDc1NQo+Pi0tLSBhL2dpdC1n
dWkvZ2l0LWd1aS5zaAo+PisrKyBiL2dpdC1ndWkvZ2l0LWd1aS5zaAo+PkBAIC0zMzU0LDYgKzMz
NTQsOSBAQCAkdWlfZGlmZiB0YWcgY29uZiBkX3MtIFwKPj4gJHVpX2RpZmYgdGFnIGNvbmYgZDwg
XAo+PiDCoCDCoCDCoCAtZm9yZWdyb3VuZCBvcmFuZ2UgXAo+PiDCoCDCoCDCoCAtZm9udCBmb250
X2RpZmZib2xkCj4+KyR1aV9kaWZmIHRhZyBjb25mIGR8IFwKPj4rIMKgIMKgIMKgLWZvcmVncm91
bmQgb3JhbmdlIFwKPj4rIMKgIMKgIMKgLWZvbnQgZm9udF9kaWZmYm9sZAo+PiAkdWlfZGlmZiB0
YWcgY29uZiBkPSBcCj4+IMKgIMKgIMKgIC1mb3JlZ3JvdW5kIG9yYW5nZSBcCj4+IMKgIMKgIMKg
IC1mb250IGZvbnRfZGlmZmJvbGQKPj5kaWZmIC0tZ2l0IGEvZ2l0LWd1aS9saWIvZGlmZi50Y2wg
Yi9naXQtZ3VpL2xpYi9kaWZmLnRjbAo+PmluZGV4IGQ0ZTJjZTMuLmNjZDRjNzAgMTAwNjQ0Cj4+
LS0tIGEvZ2l0LWd1aS9saWIvZGlmZi50Y2wKPj4rKysgYi9naXQtZ3VpL2xpYi9kaWZmLnRjbAo+
PkBAIC0zMzksNiArMzM5LDcgQEAgcHJvYyBzdGFydF9zaG93X2RpZmYge2NvbnRfaW5mbyB7YWRk
X29wdHMge319fSB7Cj4+IMKgIMKgIMKgIH0KPj4KPj4gwqAgwqAgwqAgc2V0IDo6Y3VycmVudF9k
aWZmX2luaGVhZGVyIDEKPj4rIMKgIMKgIMKgc2V0IDo6aW5fY29uZmxpY3RfcHJlX2ltYWdlIDAK
Pj4gwqAgwqAgwqAgZmNvbmZpZ3VyZSAkZmQgXAo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtYmxv
Y2tpbmcgMCBcCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC1lbmNvZGluZyBbZ2V0X3BhdGhfZW5j
b2RpbmcgJHBhdGhdIFwKPj5AQCAtNDIwLDYgKzQyMSwxNSBAQCBwcm9jIHJlYWRfZGlmZiB7ZmQg
Y29uZmxpY3Rfc2l6ZSBjb250X2luZm99IHsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2V0IGlzX2NvbmZsaWN0X2RpZmYgMQo+PiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBz
ZXQgbGluZSBbc3RyaW5nIHJlcGxhY2UgJGxpbmUgMCAxIHsgwqB9XQo+PiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZXQgdGFncyBkJG9w
Cj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNldCA6OmluX2NvbmZsaWN0X3ByZV9pbWFnZSAwCj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZWlmIHtbcmVnZXhwIHteXCtcK1x8eyRjb25m
bGljdF9zaXplfSg/OiB8JCl9ICRsaW5lXX0gewo+PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXQgaXNfY29uZmxpY3RfZGlmZiAxCj4+
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNldCBsaW5lIFtzdHJpbmcgcmVwbGFjZSAkbGluZSAwIDEgeyDCoH1dCj4+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNldCB0YWdzIGR8
Cj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNldCA6OmluX2NvbmZsaWN0X3ByZV9pbWFnZSAxCj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZWlmICgkOjppbl9jb25mbGljdF9wcmVfaW1h
Z2UpIHsKPj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc2V0IGxpbmUgW3N0cmluZyByZXBsYWNlICRsaW5lIDAgMSB7LS19XQo+PisgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXQg
dGFncyBkXy0tCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH0gZWxzZSB7Cj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHNldCB0YWdzIGRfKysKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfQo+Cj4gVGhpcyBoYXMgdGhlIHNhbWUgaXNzdWUgYXMgdGhlIGxh
c3QgcGF0Y2ggd2l0aCB2YXJpYWJsZSBzdWJzdGl0dXRpb24KPiBpbnRvIHRoZSByZWdleHAuIFJl
cGxhY2VkIHRoZSByZWdleHAgZXhwcmVzc2lvbiB3aXRoCj4gwqAgW3JlZ2V4cCAiXlxcK1xcK1xc
fHskY29uZmxpY3Rfc2l6ZX0oPzogfFwkKSIgJGxpbmVdCj4KPiBJIGNvbmZpZ3VyZWQgYSB0ZXN0
IHJlcG9zaXRvcnkgd2l0aAo+ICdtZXJnZS5jb25mbGljdHN0eWxlIGRpZmYzJyBhbmQgY291bGQg
dGVzdCB0aGlzLiBMb29rcyBmaW5lLgoKVGhhbmtzIFBhdC4KCkJ5IGxvb2tpbmcgb3ZlciB0aGUg
cGF0Y2ggKHdoaWNoIGJ5IGl0c2VsZiBpcyBub3cgc29tZSBtb250aCBvbGQpIEkKd29uZGVyZWQg
d2hldGhlciBnaXQtZ3VpIGhhcyBzb21lIHBvbGljeSB0byBzaG93IHRoZSBkaWZmIG91dHB1dCBh
cwp2ZXJiYXRpbSBhcyBwb3NzaWJsZS4gV2hpY2ggSSBicmVhayB3aXRoIHRoaXMgcGF0Y2gsIGJl
Y2F1c2UgSSByZXBsYWNlCnRoZSArKyBsaW5lIHByZWZpeCBpbiB0aGUgcHJlLWltYWdlIHdpdGgg
LS0gYW5kIGluIHRoZSB8fHx8IGxpbmVzIHdpdGgKIiAgIi4gU2hhd24sIGRvZXMgc3VjaCBwb2xp
Y3kgZXhpc3RzPwoKQmVydAoKPiAtLQo+IFBhdCBUaG95dHMgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBodHRwOi8vd3d3LnBhdHRob3l0cy50ay8KPiBQR1AgZmluZ2Vy
cHJpbnQgMkMgNkUgOTggMDcgMkMgNTkgQzggOTcgwqAxMCBDRSAxMSBFNiAwNCBFMCBCOSBERAo+
Cg==
