From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line
 up properly
Date: Wed, 16 Mar 2016 12:50:20 -0700
Message-ID: <CA+55aFxLyMaur8Kd_uyewEeehPeuZXu=Hn11SSbTYd9O6FdDBA@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b1637adf082d2052e2fd25f
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:50:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHSe-0000ZL-6j
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965557AbcCPTuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:50:23 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35976 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbcCPTuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:50:22 -0400
Received: by mail-ig0-f175.google.com with SMTP id nk17so104057920igb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/lTH1nTTs9OJwzG9Nsq05IWMOwy3/74WlIkQSEXS9H8=;
        b=oKcqzle6Mo8B0w1+zt75LslIgoM9J7DxEpqjeAs5ba0TRoz3wnWyGEJUt+XcLJrhMh
         9zGdLhdFHFVbzg2tHAWDXolwSG6tvhoH8dafzjdPattUD9hz5LzaWYTKp7oasjVO7cNZ
         K1RPpKrl1nRhWY6YSzPvO0Nqcpal6n2Gdz1VYPrCPHzGgHI7tsVhWMd/hq8TjDliigiW
         dPnX/YkQziaNoOHDGh9huDL18+Lp2jPo8gxunxldZP7joKufClPP0ijfkHlGfoVr4gZO
         9ZKzPaE1TaGvfLaLUcNEGCVbFPD8yRQVyfdibif74si5AsHluaIebUPAu9Zbnjr3WgwN
         B6sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/lTH1nTTs9OJwzG9Nsq05IWMOwy3/74WlIkQSEXS9H8=;
        b=G0yXEtUwa5lXY2JwLw4c1n+yZKCb0lmJ6iCHKpS0BtW+hL/m9fcadTqocx0pZRoXqj
         zYr3kQX5dt0CYyhSGNx3/PdV8n2coyA0pFTeOUxRJmDxAAEyckcA5aDOOFfR8MGRbImD
         LxxHX+3cEY9BOQMZAOTBtkv49CylIy45Tgn8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/lTH1nTTs9OJwzG9Nsq05IWMOwy3/74WlIkQSEXS9H8=;
        b=dqLQFkKI4pctyCc8jjqSz23izwq02vaPKI3KmTdKqfxWWwsZM2eF0C7WBJ8uCJJaYs
         vxi8J8ou1+82xlmtFUyE34FTHzqaSWNMqyYrlSLNls03GZEKWYaLDIbGi7XJPWuKUgBZ
         /0A6FnVV24ZwgEf1g3Un6zgMtdPNajRi99eYHwN+qlFvrjGkMV0cw4oqtdLIXXC8bCEu
         JBMAUY7YcrNF+1mS7yi5rczwv0M2caphRVat0B28nGR9x4r9z9KQYNpy8tJp4GbET6rv
         ctlR/kCBFkoALbY13eAB7cmKopF6ZVdbj/MdTeug9/J4sOcAFFp6obHX6H/lTsx3TUCx
         dRVw==
X-Gm-Message-State: AD7BkJLLVX1BioXvuEnMGqQKLhQXKaJBF8K0HUJGPXAJUySHsCNihol0LxcYkWOUDFuk1ObIxn7ufkwYdS5IwA==
X-Received: by 10.50.112.10 with SMTP id im10mr3317616igb.93.1458157820788;
 Wed, 16 Mar 2016 12:50:20 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 16 Mar 2016 12:50:20 -0700 (PDT)
In-Reply-To: <xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: PDgL7IkFQCvDNO33-WBwVjNEi9E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289026>

--047d7b1637adf082d2052e2fd25f
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 16, 2016 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> may give us a better structure if we are going to give users a knob
> to disable this tab expansion, i.e. move the addition of 4 spaces to
> the caller, name the body of such a function strbuf_expand_add(),
> and then make the caller do something like this perhaps?

I'd suggest just putting that knob into the "pp_handle_indent()"
function, and passing it the "pp" pointer.

In fact, maybe it should just be renamed as "pp_add_line()", and
handle every case, and keep "pp_remainder()" as just the "loop over
each line and handle the empty line and PP_SHORT special case" thing.

That makes it easty to add that CMIT_FMT_EXPAND_TABS kind of code later.

Here's an incremental patch that could be just smushed into my
previous one. It doesn't change the behavior of "pp_handle_indent()",
but I think it clarifies the code and makes future changes much easier
(partly because now nobody has to worry about the continue case and
the newline at the end of the line, so you can just print whatever you
want and then return).

What do you think?

                 Linus

--047d7b1637adf082d2052e2fd25f
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilv9gr230

IHByZXR0eS5jIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcHJldHR5LmMgYi9wcmV0
dHkuYwppbmRleCAwYjQwNDU3Zjk5ZjAuLmI5Mzc0YTE3MDhkMSAxMDA2NDQKLS0tIGEvcHJldHR5
LmMKKysrIGIvcHJldHR5LmMKQEAgLTE2OTksNiArMTY5OSwxOCBAQCBzdGF0aWMgaW50IHBwX2hh
bmRsZV9pbmRlbnQoc3RydWN0IHN0cmJ1ZiAqc2IsIGludCBpbmRlbnQsCiAJcmV0dXJuIDE7CiB9
CiAKK3N0YXRpYyB2b2lkIHBwX2FkZF9saW5lKHN0cnVjdCBwcmV0dHlfcHJpbnRfY29udGV4dCAq
cHAsCisJCQlzdHJ1Y3Qgc3RyYnVmICpzYiwgaW50IGluZGVudCwKKwkJCWNvbnN0IGNoYXIgKmxp
bmUsIGludCBsaW5lbGVuKQoreworCXN0cmJ1Zl9ncm93KHNiLCBsaW5lbGVuICsgaW5kZW50ICsg
MjApOworCWlmIChpbmRlbnQpIHsKKwkJaWYgKHBwX2hhbmRsZV9pbmRlbnQoc2IsIGluZGVudCwg
bGluZSwgbGluZWxlbikpCisJCQlyZXR1cm47CisJfQorCXN0cmJ1Zl9hZGQoc2IsIGxpbmUsIGxp
bmVsZW4pOworfQorCiB2b2lkIHBwX3JlbWFpbmRlcihzdHJ1Y3QgcHJldHR5X3ByaW50X2NvbnRl
eHQgKnBwLAogCQkgIGNvbnN0IGNoYXIgKiptc2dfcCwKIAkJICBzdHJ1Y3Qgc3RyYnVmICpzYiwK
QEAgLTE3MjEsMTIgKzE3MzMsNyBAQCB2b2lkIHBwX3JlbWFpbmRlcihzdHJ1Y3QgcHJldHR5X3By
aW50X2NvbnRleHQgKnBwLAogCQl9CiAJCWZpcnN0ID0gMDsKIAotCQlzdHJidWZfZ3JvdyhzYiwg
bGluZWxlbiArIGluZGVudCArIDIwKTsKLQkJaWYgKGluZGVudCkgewotCQkJaWYgKHBwX2hhbmRs
ZV9pbmRlbnQoc2IsIGluZGVudCwgbGluZSwgbGluZWxlbikpCi0JCQkJbGluZWxlbiA9IDA7Ci0J
CX0KLQkJc3RyYnVmX2FkZChzYiwgbGluZSwgbGluZWxlbik7CisJCXBwX2FkZF9saW5lKHBwLCBz
YiwgaW5kZW50LCBsaW5lLCBsaW5lbGVuKTsKIAkJc3RyYnVmX2FkZGNoKHNiLCAnXG4nKTsKIAl9
CiB9Cg==
--047d7b1637adf082d2052e2fd25f--
