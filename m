From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: git diff across submodules
Date: Mon, 17 Sep 2012 20:12:39 -0700 (PDT)
Message-ID: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 05:19:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDoLG-0002Wh-T4
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 05:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690Ab2IRDTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 23:19:10 -0400
Received: from nm39-vm4.bullet.mail.ne1.yahoo.com ([98.138.229.164]:23000 "HELO
	nm39-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932283Ab2IRDTI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 23:19:08 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 23:19:08 EDT
Received: from [98.138.226.177] by nm39.bullet.mail.ne1.yahoo.com with NNFMP; 18 Sep 2012 03:12:40 -0000
Received: from [98.138.88.234] by tm12.bullet.mail.ne1.yahoo.com with NNFMP; 18 Sep 2012 03:12:40 -0000
Received: from [127.0.0.1] by omp1034.mail.ne1.yahoo.com with NNFMP; 18 Sep 2012 03:12:40 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 107760.88318.bm@omp1034.mail.ne1.yahoo.com
Received: (qmail 10007 invoked by uid 60001); 18 Sep 2012 03:12:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1347937959; bh=Kiot2MtAZcoVk5W0Sm5I7KRwEEacOHyZX6raYbAJY5M=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type; b=kNWLkkSlWGZI9wrh1iYsfqOcRYbELDe0xBVXcwNb/4adNXsJgKv6Je73f9mwGRlfUcexKc44mk5mE+8o3XJD5PJpuP6szip5AZVsbsEG5xKevN1qGctxN5OB+BYj9M6BNtbyH+avkQMW0o8jHskIdPad/M2t4dnjMLy/tZ6lgSs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type;
  b=LM1l5tHR+/GAnQkqLXNUXe2n3kROqxl9LF5UZDO4gWEGiYQaPcc820PuS5FvsfKT+KVS9HCfLCYS+bKwKjw/FN7OYnv2n3RoLT/TL1XeqEIoLMwvtdEw4x1vea+SlGlQ95cAoVwbmXM6TsqQQ5qFEiHS/+pYrxkTyRD+9LHia8o=;
X-YMail-OSG: UjuQnlkVM1mhehGiuK2PybA2UnXJJ44SW8FSXF6W3kIodi.
 udhgATvFdXuo2B6kc1eFVl6L0TSinT3L.JxZb1hEs1ZB7Vr0KuK74BEbgBLA
 MLtChCfvbYaP_qURhrFkAlwEaKhKe7liWyHkWbwoMbOlA0JHlQtlAy__Ks4K
 h4x9XEShol5UyzZdJAzeYtkr.mFJFx6MmaoRJLpD6CoAQCgeBd6bGhgEnBTu
 jzBgqP5c7BLE4VByGkdzGXNN3RSwe4ESq7On7nnMTJs7HEI8E8f5Vu.RJBIw
 FnHwDtoFVSN1fmGE9U7Lf3iMiHlbPoNMEFfTYt0FQleTDp00Bxwi5H4gsuyf
 NUbqFZe95G87qgYd_eueSY7o1u5xf9htGqinidJEPtEHEFSYBoYmWtYVoLu5
 Cxs7wZUK.eLD.925yI4mha7..aeY7v_RwL3mITUQN.h51J9skxTUcJWfsVrZ
 eoXyvzyR5GL7zLQWMB5_f
Received: from [67.86.232.66] by web39403.mail.mud.yahoo.com via HTTP; Mon, 17 Sep 2012 20:12:39 PDT
X-Mailer: YahooMailClassic/15.0.8 YahooMailWebService/0.8.121.416
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205785>

Hello,
  Is there any nice way to get a diff and/or diffstat of both a project and its submodules between two revisions of the main project?

Something like 'git diff --stat tag_a tag_b' but also including the diffstat on the submodule from the revision tied to in tag_a to the revision tied to tag_b.  A few shell backflips will do it, but this seems like I'm missing something.

thanks,
-Kenny
