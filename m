From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: [ANN] mtn2git v0.1
Date: Sat, 13 Sep 2008 01:59:14 +0300
Message-ID: <94a0d4530809121559w5f644174j461ec61cb2327fd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, monotone-devel@nongnu.org, devel@pidgin.im,
	openembedded-devel@lists.openembedded.org
X-From: git-owner@vger.kernel.org Sat Sep 13 01:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeHcp-0005X3-M8
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 01:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbYILW7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbYILW7P
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:59:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:61043 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbYILW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:59:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1007143rvb.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=kdMstPvVPaHPmZLM9he3StwXICeu1ONzSteNDblrvt0=;
        b=acC21TdIz53RKZm8lNgtrpC7MUZeTHV5W6N8htpF/Lz/kDV0MD1C4kFCWNynAh8zHc
         cbUHG/NiNGzMGfNryuPkvCRDRlCg2InJfLTrY4QLVVW8BJSXK3vOJLI0f0ZmNewxnu8u
         /CMXJvPz3n1hKz4dGnRSYILrWrCe4b24GdNZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=jI4TxsRXlRVOlraY6EZ4E+mL/diElMLhrn3yU1xblvfzkmC7ByFhd2g42+EeCJYDKz
         D7bFCK7hqGw5JSVfKutjM0NMFvQWWCCTkWu+62yZfMQB1jb41NgirE1C/XebEBe3PWaB
         eEuOuPK+Fq+4IilscR8wSyADq8t8exPXXNDlU=
Received: by 10.141.88.3 with SMTP id q3mr2979983rvl.3.1221260354427;
        Fri, 12 Sep 2008 15:59:14 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Fri, 12 Sep 2008 15:59:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95785>

Hi,

This is the result of various experiments I've been doing while trying
to import mtn repositories into git. I've looked into other mtn2git
scripts but none fitted my needs.

After some rfcs on git and monotone mailing lists it seems now the
script is going in the right direction.

There are two modes:

== checkout ==

In this mode each revision is checked out and imported directly into
git. This means it's 100% sure that the result would be an exact
clone.

The disadvantage is that it's extremely slow (1 day for 25,000 commits).

== fast-import ==

This mode requires a few patches for git fast-import, it's very fast
(40 min for 25,000 commits), but not 100% reliable yet.

There are also some missing features like branch creation and updates.


My plan is to keep these two modes in the code until fast-import
method is reliable enough.

I've tried this with Pidgin's repository. The result is here:
http://github.com/felipec/pidgin-clone

It would be interesting to do something similar with OE's repo. Any takers?

Comments and patches are welcome :)

-- 
Felipe Contreras
