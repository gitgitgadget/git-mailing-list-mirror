From: James Gregory <j.gregory@epigenesys.co.uk>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Fri, 5 Aug 2011 10:24:07 +0100
Message-ID: <CAFC9htyFKm7NCNFvrUkxXpmj1jwatWkxrnRSEdztY4Syo+EQ-g@mail.gmail.com>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
	<20110804070528.GA11805@sigill.intra.peff.net>
	<CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
	<20110804183218.GA15943@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502bebec8e61a04a9bea839
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 11:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpGdb-00049G-Et
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 11:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab1HEJYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 05:24:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56760 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab1HEJYI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 05:24:08 -0400
Received: by pzk37 with SMTP id 37so3600568pzk.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=epigenesys.co.uk; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BPr61Kiivs+IUcY1/Wi3zmYopz2UCP613o2OBEqs8ac=;
        b=G/KQ5Zulp612+ZstZUgGU/QWwdsPXRhg79Qda66Ci4a8quH8yDlZ/JoYOwHPbB7E+v
         YC94ge9Z9heClKOGKLtO9M6hGPSQZltuD6FYnSGbin5C4JV/q2p6SBzp00WmwmhMLie2
         4XNm/2Bpwz4M1jsnkE6SjNtv89wDzfYZlLpK4=
Received: by 10.142.8.26 with SMTP id 26mr1821857wfh.269.1312536247461; Fri,
 05 Aug 2011 02:24:07 -0700 (PDT)
Received: by 10.142.71.15 with HTTP; Fri, 5 Aug 2011 02:24:07 -0700 (PDT)
In-Reply-To: <20110804183218.GA15943@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178782>

--00504502bebec8e61a04a9bea839
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Peff,

I've attached the valgrind.out file. If I'm reading the output
properly, it does look like it is suffering from a memory leak.

James

On 4 August 2011 19:32, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 04, 2011 at 10:08:43AM +0100, James Gregory wrote:
>
>> Thanks for your reply. I'm afraid I won't be able to allow you access
>> to repo as it is for a business project and covered by NDAs, etc. If I
>> can do anything to help with diagnosing the problem (debug logs, more
>> excerpts from the stream, etc.) then that shouldn't be a problem.
>
> Since it seems like blob data is making it into the stream in an odd
> place, my first guess would be a memory problem. Can you try installing
> valgrind (since you are on Ubuntu, there should be a package), and then
> running:
>
> =A0valgrind git fast-export --all >/dev/null 2>valgrind.out
>
> and then sharing the results of valgrind.out?
>
> -Peff
>



--=20

James Gregory
Senior Developer
epiGenesys - a University of Sheffield company
Enterprise Zone, Portobello, Sheffield, S1 4DP, UK
T: +44 (0)114 22 21884 ~ F: +44 (0)114 22 24042
www.epigenesys.co.uk ~ @epigenesys
--
This email and its attachments should be considered confidential and
are intended solely for the individual to whom the email is addressed.
If you are not the intended recipient you should take no action based
upon them, nor should you copy or show them to anyone. Any views or
opinions expressed are solely those of the author and might not
represent those of Epi Genesys Limited.
Epi Genesys Limited is registered in England and Wales with company
number 06388971 and has its registered office at 40 Leavygreave Road,
Sheffield, S3 7RD.

--00504502bebec8e61a04a9bea839
Content-Type: application/octet-stream; name="valgrind.out"
Content-Disposition: attachment; filename="valgrind.out"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gqyy5tjc0

PT0zMjY3PT0gTWVtY2hlY2ssIGEgbWVtb3J5IGVycm9yIGRldGVjdG9yCj09MzI2Nz09IENvcHly
aWdodCAoQykgMjAwMi0yMDEwLCBhbmQgR05VIEdQTCdkLCBieSBKdWxpYW4gU2V3YXJkIGV0IGFs
Lgo9PTMyNjc9PSBVc2luZyBWYWxncmluZC0zLjYuMSBhbmQgTGliVkVYOyByZXJ1biB3aXRoIC1o
IGZvciBjb3B5cmlnaHQgaW5mbwo9PTMyNjc9PSBDb21tYW5kOiBnaXQgZmFzdC1leHBvcnQgLS1h
bGwKPT0zMjY3PT0gCj09MzI2Nz09IENvbmRpdGlvbmFsIGp1bXAgb3IgbW92ZSBkZXBlbmRzIG9u
IHVuaW5pdGlhbGlzZWQgdmFsdWUocykKPT0zMjY3PT0gICAgYXQgMHg0RTM5NTEwOiBpbmZsYXRl
UmVzZXQyIChpbiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliei5zby4xLjIuMy40KQo9PTMyNjc9
PSAgICBieSAweDRFMzk2MDU6IGluZmxhdGVJbml0Ml8gKGluIC9saWIveDg2XzY0LWxpbnV4LWdu
dS9saWJ6LnNvLjEuMi4zLjQpCj09MzI2Nz09ICAgIGJ5IDB4NEQ1QjAyOiA/Pz8gKGluIC91c3Iv
YmluL2dpdCkKPT0zMjY3PT0gICAgYnkgMHg0QkIwNTk6ID8/PyAoaW4gL3Vzci9iaW4vZ2l0KQo9
PTMyNjc9PSAgICBieSAweDRCQzQ2NDogPz8/IChpbiAvdXNyL2Jpbi9naXQpCj09MzI2Nz09ICAg
IGJ5IDB4NEJDQTI5OiA/Pz8gKGluIC91c3IvYmluL2dpdCkKPT0zMjY3PT0gICAgYnkgMHg0QkNB
RkQ6ID8/PyAoaW4gL3Vzci9iaW4vZ2l0KQo9PTMyNjc9PSAgICBieSAweDRCRDE2MTogPz8/IChp
biAvdXNyL2Jpbi9naXQpCj09MzI2Nz09ICAgIGJ5IDB4NDlBRUFDOiA/Pz8gKGluIC91c3IvYmlu
L2dpdCkKPT0zMjY3PT0gICAgYnkgMHg0QjM4QUE6ID8/PyAoaW4gL3Vzci9iaW4vZ2l0KQo9PTMy
Njc9PSAgICBieSAweDRCNDIyQTogPz8/IChpbiAvdXNyL2Jpbi9naXQpCj09MzI2Nz09ICAgIGJ5
IDB4NEE5Q0QyOiA/Pz8gKGluIC91c3IvYmluL2dpdCkKPT0zMjY3PT0gCj09MzI2Nz09IAo9PTMy
Njc9PSBIRUFQIFNVTU1BUlk6Cj09MzI2Nz09ICAgICBpbiB1c2UgYXQgZXhpdDogMiw4MjEsMzc2
IGJ5dGVzIGluIDYsMjI2IGJsb2Nrcwo9PTMyNjc9PSAgIHRvdGFsIGhlYXAgdXNhZ2U6IDM1Niwx
MjMgYWxsb2NzLCAzNDksODk3IGZyZWVzLCAxLDUxNyw2MDYsOTQzIGJ5dGVzIGFsbG9jYXRlZAo9
PTMyNjc9PSAKPT0zMjY3PT0gTEVBSyBTVU1NQVJZOgo9PTMyNjc9PSAgICBkZWZpbml0ZWx5IGxv
c3Q6IDQ4LDAxNiBieXRlcyBpbiAzIGJsb2Nrcwo9PTMyNjc9PSAgICBpbmRpcmVjdGx5IGxvc3Q6
IDMwLDIyNiBieXRlcyBpbiAxLDg4OSBibG9ja3MKPT0zMjY3PT0gICAgICBwb3NzaWJseSBsb3N0
OiAwIGJ5dGVzIGluIDAgYmxvY2tzCj09MzI2Nz09ICAgIHN0aWxsIHJlYWNoYWJsZTogMiw3NDMs
MTM0IGJ5dGVzIGluIDQsMzM0IGJsb2Nrcwo9PTMyNjc9PSAgICAgICAgIHN1cHByZXNzZWQ6IDAg
Ynl0ZXMgaW4gMCBibG9ja3MKPT0zMjY3PT0gUmVydW4gd2l0aCAtLWxlYWstY2hlY2s9ZnVsbCB0
byBzZWUgZGV0YWlscyBvZiBsZWFrZWQgbWVtb3J5Cj09MzI2Nz09IAo9PTMyNjc9PSBGb3IgY291
bnRzIG9mIGRldGVjdGVkIGFuZCBzdXBwcmVzc2VkIGVycm9ycywgcmVydW4gd2l0aDogLXYKPT0z
MjY3PT0gVXNlIC0tdHJhY2stb3JpZ2lucz15ZXMgdG8gc2VlIHdoZXJlIHVuaW5pdGlhbGlzZWQg
dmFsdWVzIGNvbWUgZnJvbQo9PTMyNjc9PSBFUlJPUiBTVU1NQVJZOiA4NjI5NCBlcnJvcnMgZnJv
bSAxIGNvbnRleHRzIChzdXBwcmVzc2VkOiA0IGZyb20gNCkK
--00504502bebec8e61a04a9bea839--
