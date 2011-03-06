From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Sun, 6 Mar 2011 16:56:41 -0600
Message-ID: <20110306225641.GB24327@elie>
References: <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org>
 <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
 <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMsd-0002gK-AG
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab1CFW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:56:46 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39237 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1CFW4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:56:46 -0500
Received: by yxs7 with SMTP id 7so1416165yxs.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mS0OnweMGKaeI75PkQ8Mcuam/kxZYCwBIgA9R3dROqA=;
        b=K6UKi1vll7/uNv3Vo0rR1Ub9vc/VBa8Ew9HotrQjXYLN+gOMqVmU4UQRvsHNt6xXO3
         1tBJ/K2n67gRDfUB93Mlw/wCy7O8tY6oFKbbgNHu9uRxNBscRfd2Zxha86LGisBMjhFC
         ++Yr2UtuZBONc/EWuJjKWXzMsnKgs5ypQkp9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aZX0adE7F7ZQvqG+p3X7Ru31wuH/a4/RrpV1M2PGUoLkjyIqt7vBiC+R1UFG4HaK0b
         NtbznFC/UldqyxbHTLDtkjuQ19H49OqYAHoCmu/251CeeQCkAJXJyI/nh3fQq4tTAt50
         XadUqaTebB/3jY/CvO4vbPDI4kB+vjH5G5WqA=
Received: by 10.236.183.162 with SMTP id q22mr2058774yhm.87.1299452205720;
        Sun, 06 Mar 2011 14:56:45 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id m25sm1280899yhm.31.2011.03.06.14.56.43
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 14:56:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168547>

Junio C Hamano wrote:

> If we were to do i18n, we would probably need to include something like
> the following in the early fast-tracked part of the series, perhaps as
> part of the e6bb27e (i18n: add no-op _() and N_() wrappers, 2011-02-22)

Yep.  Is it safe to do this without the

#define ngettext git_ngettext
static inline const char *git_ngettext(...)

dance?
