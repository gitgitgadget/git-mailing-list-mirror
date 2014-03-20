From: Chris Angelico <rosuav@gmail.com>
Subject: Re: Configuring a third-party git hook
Date: Fri, 21 Mar 2014 10:46:15 +1100
Message-ID: <CAPTjJmpYREHy1cufZMuyOoXrO1Oy7QwXR+wBvm9cbgkT7SqC4Q@mail.gmail.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	<CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
	<CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
	<20140320233816.GC7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1134a0d2f9b00004f5125f53
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmfE-0003HA-0I
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760030AbaCTXqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:46:16 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51693 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759697AbaCTXqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:46:15 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so1649739pad.30
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 16:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hoj6g+RzViDZ2EKgk5ysdnbyBZOmDcku/xq1fLugUgY=;
        b=BrxvooROUaAPl2c6i6Iv0DDwh1eF6fLE/LtOVQ3B0LLJqGbVafMyxMy7IFbTIu4EQ8
         ePgOpRh3CXVJWmrdvfnr5wEwTufpiP8oTCDGtzeFvb1I+aUVJGyFcxCoTYOqE0AsDOMt
         e0R+aDsheNZmaZuw1gom86Zqw2WLMGMfEp2DeZcXSOOKvSMq7ZQctEe7NvK8LkHMPl2k
         r9x28IvrDkbZntVDK8h4JtyoKhqqQ7R0bNzjEFfiMkz6nNX3FQS2bY5/j7ykCdVF5bEi
         efJ1Rfrhn+eDcg7x1Ulu/668MFuhKwfXd5XiEuT+uCgidmaeqjMFVAlT9mciIjVv8G6x
         LZvw==
X-Received: by 10.68.215.40 with SMTP id of8mr49376540pbc.15.1395359175251;
 Thu, 20 Mar 2014 16:46:15 -0700 (PDT)
Received: by 10.68.33.7 with HTTP; Thu, 20 Mar 2014 16:46:15 -0700 (PDT)
In-Reply-To: <20140320233816.GC7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244619>

--001a1134a0d2f9b00004f5125f53
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 21, 2014 at 10:38 AM, Jeff King <peff@peff.net> wrote:
>> A comment there to the effect that "Third party tools may also define
>> their own variables" or something would make it clear that this is the
>> intention.
>
> I think this sentence from the section you linked is meant to express
> that:
>
>   You will find a description of non-core porcelain configuration
>   variables in the respective porcelain documentation.
>
> but it is rather opaque, isn't it? You did not know it, but your hook is
> a non-core porcelain. :)
>
> I think it could probably be re-worded, and possibly even indicate to
> authors of other programs that they are free to make up their own
> variables (but should take care with namespacing them appropriately).
>
> Would you like to try your hand at writing a patch?

.... oohhhhhh. Heh. I thought the "porcelain" sections of git were the
lower-level or machine-readable versions of other tools, and didn't
really think of mine as fitting into that.

How does the attached patch look?

ChrisA

--001a1134a0d2f9b00004f5125f53
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Explain-that-third-party-tools-may-create-git-config.patch"
Content-Disposition: attachment; 
	filename="0001-Explain-that-third-party-tools-may-create-git-config.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ht0oteig0

RnJvbSAxYmU3YjA5MjA1MTBiOWY0NWNhNmQzODc5Mjg5NzUzZmRjNWI1NDM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBBbmdlbGljbyA8cm9zdWF2QGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCAyMSBNYXIgMjAxNCAxMDo0NTowOCArMTEwMApTdWJqZWN0OiBbUEFUQ0hdIEV4cGxh
aW4gdGhhdCB0aGlyZC1wYXJ0eSB0b29scyBtYXkgY3JlYXRlICdnaXQgY29uZmlnJwogdmFyaWFi
bGVzCgotLS0KIERvY3VtZW50YXRpb24vY29uZmlnLnR4dCB8ICAgIDUgKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9jb25maWcudHh0IGIvRG9jdW1lbnRhdGlvbi9jb25maWcudHh0CmluZGV4IDcz
Yzg5NzMuLjIzZjA0NjYgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dAorKysg
Yi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQKQEAgLTEzMSw4ICsxMzEsOSBAQCBWYXJpYWJsZXMK
IAogTm90ZSB0aGF0IHRoaXMgbGlzdCBpcyBub24tY29tcHJlaGVuc2l2ZSBhbmQgbm90IG5lY2Vz
c2FyaWx5IGNvbXBsZXRlLgogRm9yIGNvbW1hbmQtc3BlY2lmaWMgdmFyaWFibGVzLCB5b3Ugd2ls
bCBmaW5kIGEgbW9yZSBkZXRhaWxlZCBkZXNjcmlwdGlvbgotaW4gdGhlIGFwcHJvcHJpYXRlIG1h
bnVhbCBwYWdlLiBZb3Ugd2lsbCBmaW5kIGEgZGVzY3JpcHRpb24gb2Ygbm9uLWNvcmUKLXBvcmNl
bGFpbiBjb25maWd1cmF0aW9uIHZhcmlhYmxlcyBpbiB0aGUgcmVzcGVjdGl2ZSBwb3JjZWxhaW4g
ZG9jdW1lbnRhdGlvbi4KK2luIHRoZSBhcHByb3ByaWF0ZSBtYW51YWwgcGFnZS4gT3RoZXIgZ2l0
LXJlbGF0ZWQgdG9vbHMgbWF5IGRlZmluZSB0aGVpciBvd24KK3ZhcmlhYmxlcywgd2hpY2ggd2ls
bCBiZSBkZWZpbmVkIG9uIHRoZWlyIHJlc3BlY3RpdmUgbWFudWFsIHBhZ2VzOyBpZGVhbGx5LAor
dGhlc2Ugd2lsbCBiZSBuYW1lZCBpbiBzb21lIHdheSB0byBpbmRpY2F0ZSB0aGUgcHJvamVjdCBv
ciBjcmVhdG9yLgogCiBhZHZpY2UuKjo6CiAJVGhlc2UgdmFyaWFibGVzIGNvbnRyb2wgdmFyaW91
cyBvcHRpb25hbCBoZWxwIG1lc3NhZ2VzIGRlc2lnbmVkIHRvCi0tIAoxLjcuMTAuNAoK
--001a1134a0d2f9b00004f5125f53--
