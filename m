From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Mon, 23 May 2011 10:07:13 -0700
Message-ID: <7vzkmduz0e.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 19:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOYbO-0007OS-4u
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 19:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab1EWRHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 13:07:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab1EWRHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 13:07:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D9B15B09;
	Mon, 23 May 2011 13:09:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SJzWB6rcx1OHkd7AUk8dCIQUSME=; b=Qb+HzS
	gD1RsWYOldK/NQk+hU6hwlx3tFQrxsY40tWGyk2Ir7Jye37evBbxIJksHFgPDBnh
	xxwSoVUwIGIexnRyb6z5UpXvmkAWKwsLbZ/IgmzuKRcHW8qeT72M9DcaiWkHQsI5
	wq2KImrvt2za5eT6IDMjyZPTKs4DW/5TIDp10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZhDRnBJOmP2BCMAAQjIIsbRYbuWM3w4
	yzKsin7RzKTBuJJf07jNW1en70q/tFqdqfpagBXBHzCkOD1KzO1zGaiO/MIXVXTk
	LfLo9DxHNZfisaeDsDdOUIFxMxL43G+Y0zxmffOKDCIc1EeYP+nBktAjpfca4hiZ
	m0c8bYfvCX8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09E1C5B08;
	Mon, 23 May 2011 13:09:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC2D15B04; Mon, 23 May 2011
 13:09:21 -0400 (EDT)
In-Reply-To: <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com> (Jay
 Soffian's message of "Mon, 23 May 2011 11:17:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69812574-855F-11E0-ABF9-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174253>

Here is a quick summary of what I have in the "talked about, sounded
interesting, and never got completed" list.


gmane=http://thread.gmane.org/gmane.comp.version-control.git/

* Teach pack protocol to transfer estimated pack size and history
  depth to allow receiving end make more intelligent decision between
  unpack-objects and index-pack.

  $gmane/173610

* The "combined" diff always assumes it deals with text files. Teach it
  to punt on binary and also use the textconv.

  $gname/171613

* Audit use of symbolic-ref without -m in our scripts and for each
  case decide if leaving a reflog entry for the HEAD is desirable.
  If so, add them.

  $gmane/172516

* "git status" on intent-to-add index entries (say "I" in the first
  column instead of "A" for short status, add "(needs 'git add')" at the
  end of "new file: $path " in long status).

  $gmane/170658

* synopsys: use {} instead of () for grouping alternatives (Jari Aalto)
  $gmane/72243

* "[alias] st = status" and "cd .git && git st" (Jeff King)
  $gmane/72327
