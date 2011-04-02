From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/5] tree-walk: match_entry microoptimization
Date: Sat, 2 Apr 2011 16:06:56 +0700
Message-ID: <BANLkTikZ=eH-Jdd-kdvw4JKPbqCr7kviZg@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com> <1301535481-1085-5-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 11:07:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5wo3-0001Kb-SY
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 11:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab1DBJH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 05:07:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37948 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab1DBJH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 05:07:26 -0400
Received: by pzk9 with SMTP id 9so838607pzk.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=S5V3eFJnnlRizmvu5g/00AKvnqG/dFPXuyB0hQn1USk=;
        b=SCCFQRdS3Go7RsReX4Kffo62dSNXiHbzaBrVOJr5q7ofnniVvFIYL4arSsyKVFA130
         dQrmaTLNYHZgOXkmdWmEWrLD7yLVT54QdR201ZTfngkwhX8F84gkFMaQuV8D8HD9GFmj
         Bt58bWQ9TL61Mkzb9b4+uJZsxprP/hIsQiyKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GsF6wSUi3sqqr/iRnnvAqPCX10XJtdcq4AFt2CjjeEroMyt+YSMHCas+CJZh+JaTt6
         3qpxjFsElWY61uexjMbbS3Ny4y32X+/rjuEoPSzY9eGckoGyu088q5onQFJgJlNZdSme
         l01jSGgmRZamP34GKfD/QFoaqm6dSiNWdTn+8=
Received: by 10.142.142.4 with SMTP id p4mr4247518wfd.43.1301735246064; Sat,
 02 Apr 2011 02:07:26 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Sat, 2 Apr 2011 02:06:56 -0700 (PDT)
In-Reply-To: <1301535481-1085-5-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170646>

On Thu, Mar 31, 2011 at 8:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> Before calling strncmp(), see if we can get away with checking only the
> first character of the passed path components instead.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

I wonder if inlining strcmp() would be better (at least cleaner code).
It seems like you try to avoid the function call cost here.
-- 
Duy
