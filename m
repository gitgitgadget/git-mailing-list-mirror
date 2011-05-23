From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Mon, 23 May 2011 11:54:18 +0100
Message-ID: <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com>
References: <20110522114917.GA19927@arf.padd.com> <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Grant Limberg <glimberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 12:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOSml-0002y3-Of
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 12:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1EWKyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 06:54:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51538 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab1EWKyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 06:54:49 -0400
Received: by iwn34 with SMTP id 34so4650909iwn.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=1qb6KOQK+tTosaabDxuFEg+0fepWUUOulRzgtJvahSU=;
        b=bNSNzf0U+HGicsO5HTtj0+tNqwzoVicbaQnGOdFKSKvwIb4vR5iicKIY7i+nhq/2qv
         rqVEiTb4fIoIO8JBsxlVLMaUVF81otf2/2wvkU3fHMif+yxs97OTUtlqa+K/+4kpyWtd
         ypXVrXuTO2oZtkSgLGvDNvaSFV70uAHrHdpRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T/jzlnf39B8qloqBLE+vV7yuTRpQBsyESHMUwbs2rrBoxQ/AjB0mC4c1VepUh2rc5w
         sWYeeaDF1qLiC2SF9zTOU0vSoUs+w7X6HhES86UJie+wpQzx6TigJ/IZIbNefLrcKbfV
         Avm4+1lvCNHAR/AOdi3hexritGn4BkksUXlI0=
Received: by 10.231.197.27 with SMTP id ei27mr1938982ibb.198.1306148089124;
 Mon, 23 May 2011 03:54:49 -0700 (PDT)
Received: by 10.231.17.66 with HTTP; Mon, 23 May 2011 03:54:18 -0700 (PDT)
In-Reply-To: <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174236>

Hi Grant,

I think I saw that happening when there is nothing to import or in
situations where the parent of a certain branch does not exist.

Perforce does not strictly require branch definitions to allow a branch
structure/flow. It is quite possible that you are integrating stuff
around without using "branch specs". When git-p4 is importing your P4
database it will look at all branches available in the server, including
ones from other depots. So it is possible that while you are seeing a
big list of branches being processed, none apply to the branch structure
you are trying to import.

Could you please confirm that you have Perforce branch specs for all
branches that you are trying to import?

Thanks,
Vitor
