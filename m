From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shallow clone not very shallow due to tags
Date: Mon, 15 Aug 2011 21:03:19 +0700
Message-ID: <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com>
References: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 16:03:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsxlj-0001QL-UF
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 16:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab1HOODv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 10:03:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42842 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab1HOODu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 10:03:50 -0400
Received: by bke11 with SMTP id 11so3013027bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E/FtNUA0DwSLigXBNtCK2cuk6L36J3lfjQuaZm31Bm4=;
        b=nSZaJisKTNuXoBmc6tHEskUzr08WFAXpNb44mdxDh5Uc5UlrYeaVgdVrqPUqn5cO91
         TRNym6JikVD8fwLKYkV3lPuxHxrPBjSWTCfitv7CP1S/ehEqjay4bwGq7nfF4+9PV9fy
         OdDW+4R/vyGuy18qHXUMw0elmEEPT+MuUat3Y=
Received: by 10.205.34.130 with SMTP id ss2mr945666bkb.175.1313417029131; Mon,
 15 Aug 2011 07:03:49 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Mon, 15 Aug 2011 07:03:19 -0700 (PDT)
In-Reply-To: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179365>

On Mon, Aug 15, 2011 at 6:58 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Uhm. That is not a very shallow clone. The clone copied 20234 objects
> at 9.15 MiB... so its ~20 MiB lighter than a full clone. But nearly
> all of the tags exist, because the clone client is declaring want
> lines for them, making the server generate up to 1 commit back from
> the wanted tag. I know shallow support is the feature nobody wants to
> think about, but this just seems broken to me. Clients performing a
> shallow clone shouldn't be asking for tags... but they should be using
> the include-tag protocol option so that if they do happen to receive a
> tagged commit, the tag object will also be sent.

The same would apply if the repo in question has many branches. Should
we fetch only master (or a user-specified set of refs) in shallow
clone?
-- 
Duy
