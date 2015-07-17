From: Michael Darling <darlingm@gmail.com>
Subject: Re: [PATCH] Documentation: Alternate name for docbook2x-texi binary
Date: Thu, 16 Jul 2015 20:43:36 -0400
Message-ID: <CABRuA+iM4-td27tGS6Fh4YKBxChFqU2ezF+ewstsM_59MrUo7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0141aafe6f1f1b051b077a29
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 02:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFtkk-00069c-8Q
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 02:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201AbbGQAni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 20:43:38 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34799 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380AbbGQAnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 20:43:37 -0400
Received: by wgkl9 with SMTP id l9so70581045wgk.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FvpNfPcUsrDZt4Mo9HmLLjFDVuKK8K053vFdqMQKjIw=;
        b=aNAfcVq1f+GZ5uzb4/qmU+N9vjXv9wLc2yEDm6X68p9TpROM5HYGf4ozaoesChrqFF
         d48mOATdHPtYcfSLQXSReFOo8+d3KkCvDVXeVrDRPYqysqtgRUMmPKN2yALm6EQiKjSj
         bk5lX7xpUjbRkf/sUGyAopLbL8qRb9K3fiu2BxtYlpaEBjYF6xBhHtRUP0huR5z8ESZe
         q9ABbekR5iTW5juVl74++plwbYj6WGWZjgv22//rbyMAX0zis61JP2AAN0ozBPXu0WY7
         uxEjaNyO7ekDvGKgLD4K0ZkXaWPkZHUQiJ862tQPfEVboxszHzEf1e5whEomQLn4WFGn
         zVHQ==
X-Received: by 10.194.178.99 with SMTP id cx3mr23444157wjc.33.1437093816365;
 Thu, 16 Jul 2015 17:43:36 -0700 (PDT)
Received: by 10.28.50.129 with HTTP; Thu, 16 Jul 2015 17:43:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274055>

--089e0141aafe6f1f1b051b077a29
Content-Type: text/plain; charset=UTF-8

Ping.  Don't have write access.

Applied as an attachment, in case there were any formatting issues.

On Wed, May 13, 2015 at 4:28 AM, Michael Darling <darlingm@gmail.com> wrote:
> In Fedora 21, docbook2x-texi binary is named db2x_docbook2texi.
> If binary docbook2-texi is not found, looks for db2x_docbook2texi.
> Also gives an error if neither is found.
>
> Signed-off by: Michael Darling <darlingm@gmail.com>
> ---
>  Documentation/Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3e39e28..f5f9ad5 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -116,7 +116,15 @@ HTML_REPO = ../../git-htmldocs
>
>  MAKEINFO = makeinfo
>  INSTALL_INFO = install-info
> -DOCBOOK2X_TEXI = docbook2x-texi
> +
> +DOCBOOK2X_TEXI = $(shell which docbook2x-texi)
> +ifeq (, $(DOCBOOK2X_TEXI))
> +DOCBOOK2X_TEXI = $(shell which db2x_docbook2texi)
> +ifeq (, $(DOCBOOK2X_TEXI))
> +$(error Did not find docbook2x-texi or db2x_docbook2texi, required)
> +endif
> +endif
> +
>  DBLATEX = dblatex
>  ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
>  ifndef PERL_PATH
> --
> 2.4.0.53.g8440f74

--089e0141aafe6f1f1b051b077a29
Content-Type: application/octet-stream; name="git.doc.patch"
Content-Disposition: attachment; filename="git.doc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ic6wjphj0

LS0tCiBEb2N1bWVudGF0aW9uL01ha2VmaWxlIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vTWFrZWZpbGUgYi9Eb2N1bWVudGF0aW9uL01ha2VmaWxlCmluZGV4IDNlMzllMjguLmY1
ZjlhZDUgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vTWFrZWZpbGUKKysrIGIvRG9jdW1lbnRh
dGlvbi9NYWtlZmlsZQpAQCAtMTE2LDcgKzExNiwxNSBAQCBIVE1MX1JFUE8gPSAuLi8uLi9naXQt
aHRtbGRvY3MKCiBNQUtFSU5GTyA9IG1ha2VpbmZvCiBJTlNUQUxMX0lORk8gPSBpbnN0YWxsLWlu
Zm8KLURPQ0JPT0syWF9URVhJID0gZG9jYm9vazJ4LXRleGkKKworRE9DQk9PSzJYX1RFWEkgPSAk
KHNoZWxsIHdoaWNoIGRvY2Jvb2syeC10ZXhpKQoraWZlcSAoLCAkKERPQ0JPT0syWF9URVhJKSkK
K0RPQ0JPT0syWF9URVhJID0gJChzaGVsbCB3aGljaCBkYjJ4X2RvY2Jvb2sydGV4aSkKK2lmZXEg
KCwgJChET0NCT09LMlhfVEVYSSkpCiskKGVycm9yIERpZCBub3QgZmluZCBkb2Nib29rMngtdGV4
aSBvciBkYjJ4X2RvY2Jvb2sydGV4aSwgcmVxdWlyZWQpCitlbmRpZgorZW5kaWYKKwogREJMQVRF
WCA9IGRibGF0ZXgKIEFTQ0lJRE9DX0RCTEFURVhfRElSID0gL2V0Yy9hc2NpaWRvYy9kYmxhdGV4
CiBpZm5kZWYgUEVSTF9QQVRICg==
--089e0141aafe6f1f1b051b077a29--
