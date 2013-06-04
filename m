From: ojab <ojab@ojab.ru>
Subject: [PATCH] Fix `git svn rebase` if top-level HEAD directory exist
Date: Tue, 04 Jun 2013 11:32:56 +0400
Message-ID: <51AD9828.7080508@ojab.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040301020804060506020109"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 09:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujljw-0008Gf-88
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 09:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759617Ab3FDHdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 03:33:04 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:48282 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759368Ab3FDHdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 03:33:02 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so4306360lab.40
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 00:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:x-gm-message-state;
        bh=3RZsYqxvgse7z89NKhh441F8V9bSAQUZAKYHGFwPE0o=;
        b=KzbPpjpmtR2t7H7+YOgmvngNFL+sy5j/mnZLG6d3ImKvW8JpEZUpfYmKEHRipTPB6U
         Igq18spP3Thw+Yw4tbwTALe/MStnOPVSTg6D/34G+k3yYGW0O8nA3bvZLC+N1VoNOh8l
         hNavJEc5QR7rm/hlT+EyvqXpdWL0zmtGzSETuf52eR9INYCRAT7tpl9cwPQ4YvlCRpUP
         Y/mJ1SCmRwHypalm4mOo3JPNDPxSu/4VP2zngSpuITNK4u7M67K7hk8Qh9bXGPfTdegO
         sByB4pqcWm3YzzruZqSxNnMi2pDWWkiv9CAUsJ3ciMF1R3k47nPJ/1IwJAWNJ3HH/43N
         N1/Q==
X-Received: by 10.112.181.130 with SMTP id dw2mr11665830lbc.81.1370331180581;
        Tue, 04 Jun 2013 00:33:00 -0700 (PDT)
Received: from ojab.ru (cl-154.led-01.ru.sixxs.net. [2a02:578:5002:99::2])
        by mx.google.com with ESMTPSA id o6sm4820755laj.2.2013.06.04.00.32.57
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 00:32:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:23.0) Gecko/20100101 Thunderbird/23.0a1
X-Gm-Message-State: ALoCoQleSOMm8MDKe9je+Rw363WcJCVuLzDCXH2EkYwcrAUA+t+tyIHoKxybg/GDxpmXdqRqP0us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226321>

This is a multi-part message in MIME format.
--------------040301020804060506020109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Oh hai!
I have a svn repo with the top-level directory named HEAD and `git svn 
rebase [HEAD] [--]` fails with
> $ git svn rebase
> fatal: ambiguous argument 'HEAD': both revision and filename
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> rev-list --first-parent --pretty=medium HEAD: command returned error: 128

Works fine with patch in the attached file. please review.

//wbr ojab

--------------040301020804060506020109
Content-Type: text/plain; charset=UTF-8;
 name="0001-Fix-git-svn-rebase-if-top-level-HEAD-directory-exist.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Fix-git-svn-rebase-if-top-level-HEAD-directory-exist.pa";
 filename*1="tch"

RnJvbSA1MjJjYmM4YjhhN2M0ZjJhYjQyNjg1NTFhNTUwNTg1NzUzMTY0Njc3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBvamFiIDxvamFiQG9qYWIucnU+CkRhdGU6IFR1ZSwg
NCBKdW4gMjAxMyAxMToyODoxNiArMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBgZ2l0IHN2
biByZWJhc2VgIGlmIHRvcC1sZXZlbCBIRUFEIGRpcmVjdG9yeSBleGlzdApTaWduZWQtb2Zm
LWJ5OiBvamFiIDxvamFiQG9qYWIucnU+CgotLS0KIGdpdC1zdm4ucGVybCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2dpdC1zdm4ucGVybCBiL2dpdC1zdm4ucGVybAppbmRleCBkMDcwZGUwLi5lMzVhNjZh
IDEwMDc1NQotLS0gYS9naXQtc3ZuLnBlcmwKKysrIGIvZ2l0LXN2bi5wZXJsCkBAIC0xOTMy
LDcgKzE5MzIsNyBAQCBzdWIgY210X3NoYTJyZXZfYmF0Y2ggewogc3ViIHdvcmtpbmdfaGVh
ZF9pbmZvIHsKIAlteSAoJGhlYWQsICRyZWZzKSA9IEBfOwogCW15IEBhcmdzID0gcXcvcmV2
LWxpc3QgLS1maXJzdC1wYXJlbnQgLS1wcmV0dHk9bWVkaXVtLzsKLQlteSAoJGZoLCAkY3R4
KSA9IGNvbW1hbmRfb3V0cHV0X3BpcGUoQGFyZ3MsICRoZWFkKTsKKwlteSAoJGZoLCAkY3R4
KSA9IGNvbW1hbmRfb3V0cHV0X3BpcGUoQGFyZ3MsICRoZWFkLCAiLS0iKTsKIAlteSAkaGFz
aDsKIAlteSAlbWF4OwogCXdoaWxlICg8JGZoPikgewotLSAKMS44LjIKCg==
--------------040301020804060506020109--
