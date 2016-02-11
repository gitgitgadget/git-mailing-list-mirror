From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Thu, 11 Feb 2016 09:48:36 +0100
Message-ID: <56BC4AE4.6060708@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 09:56:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTn2g-0004Hk-9B
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 09:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbcBKIzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 03:55:53 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55816 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbcBKIzw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 03:55:52 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2016 03:55:52 EST
X-AuditID: 12074413-eefff7000000516b-b3-56bc4ae60191
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C4.B0.20843.6EA4CB65; Thu, 11 Feb 2016 03:48:38 -0500 (EST)
Received: from [192.168.69.130] (p548D69E5.dip0.t-ipconnect.de [84.141.105.229])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1B8maJm000337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Feb 2016 03:48:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-21-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqPvMa0+Ywe5nuhbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDMO/trOUnCKvWLSrCOMDYz/WbsYOTkkBEwk
	lt88wdzFyMUhJLCVUWLj5a1sIAkhgQtMEs3f3EBsYQFHiQ3XJ7KA2CICDhKXdx2FamhjlOh4
	cRRsEpuArsSinmYmEJtXQFvi77XHYHEWAVWJ25vWgtmiAiES778+Z4WoEZQ4OfMJ2FBOAU+J
	aVua2UFsZgE9iR3Xf7FC2PISzVtnM09g5JuFpGUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3W
	LU5OzMtLLdI118vNLNFLTSndxAgJPeEdjLtOyh1iFOBgVOLh/VGzO0yINbGsuDL3EKMkB5OS
	KO9Btz1hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4nW2BcrwpiZVVqUX5MClpDhYlcV61Jep+
	QgLpiSWp2ampBalFMFkZDg4lCd4GT6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKM
	eFDsxRcDow8kxQO09zBIO29xQWIuUBSi9RSjLseCH7fXMgmx5OXnpUqJ894BKRIAKcoozYNb
	AUs0rxjFgT4W5hUHph0hHmCSgpv0CmgJE9CSHd93gSwpSURISTUwRuqYbTjU+t7w5qXtX4Xs
	+Jw2rGorLv+1yWfDr4KTR38qTvdJMZPQqPsbWa6WPE3+xIJbC9Lmrzs4NXnCzQ7zpdrp38qm
	7H0cnhquUrCh/hjPQv8/639P3rp78YHpyfs21u2VezDhj+nXn1sML4lalDAkiTbN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285952>

On 02/05/2016 08:44 PM, David Turner wrote:
> Add a database backend for refs using LMDB.  This backend runs git
> for-each-ref about 30% faster than the files backend with fully-packe=
d
> refs on a repo with ~120k refs.  It's also about 4x faster than using
> fully-unpacked refs.  In addition, and perhaps more importantly, it
> avoids case-conflict issues on OS X.

When I compile this using gcc with -Werror=3Dpointer-arith, I get the
following errors:

> refs/lmdb-backend.c: In function =91rename_reflog_ent=92:
> refs/lmdb-backend.c:1068:39: error: pointer of type =91void *=92 used=
 in arithmetic [-Werror=3Dpointer-arith]
>   strbuf_add(&new_key_buf, key.mv_data + key.mv_size - 8, 8);
>                                        ^
> refs/lmdb-backend.c:1068:53: error: pointer of type =91void *=92 used=
 in arithmetic [-Werror=3Dpointer-arith]
>   strbuf_add(&new_key_buf, key.mv_data + key.mv_size - 8, 8);

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
