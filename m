From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: t4015-diff-whitespace broken on cygwin's bash
Date: Fri, 13 Oct 2006 11:12:31 +0200
Message-ID: <81b0412b0610130212uca8371fg92db5081a8175cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24298_29405790.1160730751260"
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Oct 13 11:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYJ5o-0003Y3-AE
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 11:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJMJMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 05:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWJMJMd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 05:12:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:60445 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWJMJMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 05:12:33 -0400
Received: by nf-out-0910.google.com with SMTP id x30so886642nfb
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 02:12:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=O9zCLS15bmHq8Ug46112a1KEP8AummfKkSPfJgEa5TUo37d+ZIEHpf+Vt8HUSiexK0lF5L4/9fl3Bg0RFCjltw0JVkauS3dL7HcVIe0SXFW1xPG1cSGQeIsjY6JPLA6Q+aizk9XjJbXW+WDIe8djUp9I1mGSt7rUJCvAtdvpyKY=
Received: by 10.78.203.13 with SMTP id a13mr3438285hug;
        Fri, 13 Oct 2006 02:12:31 -0700 (PDT)
Received: by 10.78.115.8 with HTTP; Fri, 13 Oct 2006 02:12:31 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28835>

------=_Part_24298_29405790.1160730751260
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It seem to cut off the last CR from text-here. I.e.

  cat <<EOF >x
  ...
  CR at end^M
  EOF

becomes just "CR at end" in the output file, that is ^M (aka CR) stripped.
The attached workaround worked for me, but is, as usual, too ugly to
sign it off.

------=_Part_24298_29405790.1160730751260
Content-Type: application/xxxxx; name="fix-t4015-diff-whitespace.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fix-t4015-diff-whitespace.patch"
X-Attachment-Id: file0

Y29tbWl0IDAwMTc5OTkxOGJhMGI3MTZjMzllMDRlMjhlMWIwNmY2NTYxMDIxOTMKQXV0aG9yOiBB
bGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRlOiAgIEZyaSBPY3QgMTMgMTE6MDU6
MTcgMjAwNiArMDIwMAoKICAgIGZpeCB0NDAxNS1kaWZmLXdoaXRlc3BhY2Uuc2ggb24gY3lnd2lu
CgpkaWZmIC0tZ2l0IGEvdC90NDAxNS1kaWZmLXdoaXRlc3BhY2Uuc2ggYi90L3Q0MDE1LWRpZmYt
d2hpdGVzcGFjZS5zaAppbmRleCBjOTQ1MDg1Li5jZTQ3YThhIDEwMDc1NQotLS0gYS90L3Q0MDE1
LWRpZmYtd2hpdGVzcGFjZS5zaAorKysgYi90L3Q0MDE1LWRpZmYtd2hpdGVzcGFjZS5zaApAQCAt
NTcsOCArNTcsOCBAQCB3aGl0ZXNwYWNlIGNoYW5nZQogd2hpdGVzcGFjZSBpbiB0aGUgbWlkZGxl
CiB3aGl0ZXNwYWNlIGF0IGVuZAogdW5jaGFuZ2VkIGxpbmUKLUNSIGF0IGVuZA0KIEVPRgorZWNo
byAtbmUgJ0NSIGF0IGVuZFxyXG4nID4+eAogCiBnaXQtdXBkYXRlLWluZGV4IHgKIApAQCAtODYs
OSArODYsOSBAQCBpbmRleCBkOTlhZjIzLi44YjMyZmI1IDEwMDY0NAogK3doaXRlIHNwYWNlIGlu
IHRoZSBtaWRkbGUKICt3aGl0ZXNwYWNlIGF0IGVuZCAgCiAgdW5jaGFuZ2VkIGxpbmUKLS1DUiBh
dCBlbmQNCi0rQ1IgYXQgZW5kCiBFT0YKK3ByaW50ZiAnJXNDUiBhdCBlbmRcclxuJyAtID4+ZXhw
ZWN0CitwcmludGYgJytDUiBhdCBlbmRcbicgPj5leHBlY3QKIGdpdC1kaWZmID4gb3V0CiB0ZXN0
X2V4cGVjdF9zdWNjZXNzICdhbm90aGVyIHRlc3QsIHdpdGhvdXQgb3B0aW9ucycgJ2RpZmYgLXUg
ZXhwZWN0IG91dCcKIApAQCAtMTEzLDkgKzExMyw5IEBAIGluZGV4IGQ5OWFmMjMuLjhiMzJmYjUg
MTAwNjQ0CiArd2hpdGUgc3BhY2UgaW4gdGhlIG1pZGRsZQogK3doaXRlc3BhY2UgYXQgZW5kICAK
ICB1bmNoYW5nZWQgbGluZQotLUNSIGF0IGVuZA0KLStDUiBhdCBlbmQKIEVPRgorcHJpbnRmICcl
c0NSIGF0IGVuZFxyXG4nIC0gPj5leHBlY3QKK3ByaW50ZiAnK0NSIGF0IGVuZFxuJyA+PmV4cGVj
dAogZ2l0LWRpZmYgLWIgPiBvdXQKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2Fub3RoZXIgdGVzdCwg
d2l0aCAtYicgJ2RpZmYgLXUgZXhwZWN0IG91dCcKIAo=
------=_Part_24298_29405790.1160730751260--
