From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git reflog on a tag tries to do something unexpected
Date: Fri, 19 Apr 2013 21:31:35 +1000
Message-ID: <CACsJy8BfgQXVQpNNUfqY0-0srpm1Lq8rHyB4gFkZ10UJ+Yii5Q@mail.gmail.com>
References: <20130419090819.40f7c071@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Apr 19 13:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT9Y5-0001es-2p
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 13:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968158Ab3DSLcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 07:32:08 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:47004 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968066Ab3DSLcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 07:32:07 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so3735289oag.37
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Vm1+4c4vkeNZ8lvFz5KU8xtiTgYAArdOFSeiIIGfoIw=;
        b=HIrzfbhGvVIwb4KiUR0KwFAdc6Uck33zmY4TdBkW5bX71rl0j/Vqltg3V7WAP5hkaa
         POS4/V1FL2zNCDwg3YtsQk9P1Irb7fdaW6/+xEx6pC/qo0iPfibo97B1vN1R55rddwZi
         xwkgVWKgpE2T08KYyuDqamhvA9yfiBmFZ+m3goB+WbLzwt5kMg/NcBmCQB6egNnHaWLG
         9s7Qe1PvAASNf/HgkpdNug5QY3OO+9JgxirxpGrqAapseNRa5hvUAgplSGp/edQomu4d
         PQ3miy4pGCP8O/LT+nGYdHf+jhrkmjlg59GJAvZ/kOaTX0F0XUiOLI4Pysyw4Xz62jEr
         hS8w==
X-Received: by 10.182.204.5 with SMTP id ku5mr3606158obc.22.1366371125679;
 Fri, 19 Apr 2013 04:32:05 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Fri, 19 Apr 2013 04:31:35 -0700 (PDT)
In-Reply-To: <20130419090819.40f7c071@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221759>

On Fri, Apr 19, 2013 at 5:08 PM, Yann Dirson <dirson@bertin.fr> wrote:
> git reflog, when applied to a tag, should surely bail out saying there is reflog
> for the requested reference.  However, instead it spits out a single line of
> abbreviated sha1's of an ancestry walk:
>
> $ git reflog --decorate v1.8.2.1
> 5bda18c (tag: v1.8.2.1) 6466fbb 2137ce0 (tag: v1.8.1.6) 4bbb830 0e9b327 ...

Also "git reflog --decorate origin/master^{}" should have bailed out
instead of printing nothing.
-- 
Duy
