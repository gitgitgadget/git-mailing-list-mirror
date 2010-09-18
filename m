From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: replace cut with ${v%% *}
Date: Sat, 18 Sep 2010 00:25:16 -0500
Message-ID: <AANLkTi=9rDR0chmPrjK3eAKgg_ECbAjcUYhvP_GELdvc@mail.gmail.com>
References: <7vsk182p2q.fsf@alter.siamese.dyndns.org>
	<0eafa42f1da5f66465a1eb9da170416363cf72e0.1284759770.git.chris_johnsen@pobox.com>
	<7v8w302fu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 07:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owpvd-000189-Ds
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 07:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0IRFZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 01:25:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57532 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0IRFZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 01:25:17 -0400
Received: by bwz11 with SMTP id 11so3292065bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 22:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=8eJ5GamcAqoA3XFKnpukqmdUd0cIIEMHPPuIoIQdUiE=;
        b=PecfWt+Dx28q7SUqWAeNZisbPNLxyE3HLQLeXoylKAIrXC7xKcl/YC43yYTrkl6uK5
         W8joAcBs+CbHYI8IfvNOxSmx2f4TJ0aLkANdv/Ui4fJVoMg3YfE+rZ516ju9fpnchQ49
         xabtdzAz2ez9bDnDyDaMH9Z38YMobK/P77QsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ACIodPD3xrG5Rn/scdKbI1gDuurJL8WP7WuO1pJP1EiE4XFjj3D8O6XnBGfmyfiCTG
         FxI2y2B/on4/o0Qn0ar9WAG2PmTtGIBZ3zyUX8BBJ9etxohERQ++y0mOdLddgQ+Gi84/
         sJX6tKZ4SfjgDs8FcTntARd1A3IbkqBNyeJrk=
Received: by 10.223.103.203 with SMTP id l11mr2328451fao.82.1284787516231;
 Fri, 17 Sep 2010 22:25:16 -0700 (PDT)
Received: by 10.223.124.134 with HTTP; Fri, 17 Sep 2010 22:25:16 -0700 (PDT)
In-Reply-To: <7v8w302fu1.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: YwrmtYymP0vXCv-mJN56bXQTHV0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156431>

Junio C Hamano <gitster@pobox.com> wrote:
> Chris Johnsen <chris_johnsen@pobox.com> writes:
>> It seems like the other uses of cut in git-rebase--interactive.sh
>> would be more awkward if they were replaced with equivalent
>> processing done in-shell with parameter expansions...
>
> More importantly, they are fed output from rev-list and do not have
> breakage you observed on your Mac OS box, do they?
>
> IOW, I don't see anything that needs fixing in other uses.

Right, the other uses of cut do not cause any problems on my system.

Any remaining reason to change them would be along the lines of your
"the less of 'cut' we see, the better" and the possible efficency of
in-shell processing (e.g. for msys/cygwin).

-- 
Chris
