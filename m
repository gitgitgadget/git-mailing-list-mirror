From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 16:20:28 -0400
Message-ID: <CADFUPgfHQCzdnXfby5b+z-pRkt5o6MAVEf_1waWER3iVtM1TZA@mail.gmail.com>
References: <1343753854-66765-1-git-send-email-dark.panda@gmail.com> <7vehnrkdrq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:20:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIw4-0007XL-JU
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab2GaUUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:20:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54382 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab2GaUUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:20:49 -0400
Received: by obbuo13 with SMTP id uo13so11088792obb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2ssq7GHTW+JRr1f1ygQ3YuSQ8niJEl4LkO6VYAa97z8=;
        b=pGl8BgEn9dNTjqNudGw3XSm98qMKcmjB0CVPNuEcGSyP1kVzePDJ8C1iMCUqunX3LR
         fr//w2Jx0L0FX5DJs+oh+sjtkaExXJ2+5fcz8s6yTbnE79+VSqUTvkToA24MdlJU+sSh
         TowpVCjq2TcaeD+Gous/e2wKUCGj+IXl3n2/S4eDhfhrdNXhwHDZMcPYAq3R3aKRQ1TU
         0SZPXm8RVrcM/v47cG8Q7hu6MafvVtioddxh4lLYjtx5uYhRheLrpq+vkohXg5QoZtKJ
         D8Fvq0T81hvA+xIWHLO61aO7w0/ARVPeYhPjLb26OVHCEb/fEVyYm2Ln4DBrZ0CQ3Mid
         euMw==
Received: by 10.182.131.73 with SMTP id ok9mr25241695obb.19.1343766048879;
 Tue, 31 Jul 2012 13:20:48 -0700 (PDT)
Received: by 10.76.168.200 with HTTP; Tue, 31 Jul 2012 13:20:28 -0700 (PDT)
In-Reply-To: <7vehnrkdrq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202681>

On Tue, Jul 31, 2012 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Turning "grep.extendedregexp" from boolean to an extended boolean to
> allow "grep.extendedregexp = perl" might be a better alternative.
> That way, the user wouldn't have to worry about 7 variants of
> grep.fooRegexp variables twenty years down the road, even though the
> set of possible values given to "grep.extendedregexp" may have grown
> over time by then.

Yeah, that sounds good. I've re-written the patch to accommodate the
change allowing for the current boolean settings of true/false as well
as "perl". For the sake of completeness (verbosity? pedantry?) I also
included a setting for "extended" which is equivalent to true.

With this sort of change, would a more generic "grep.regexpMode",
"grep.patternType" or something similar perhaps be more descriptive,
with "grep.extendedRegexp" being aliased for backwards compatibility
purposes? I could also add that functionality if desired.
