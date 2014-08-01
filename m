From: Shawn Pearce <spearce@spearce.org>
Subject: Re: article: Using a rolling hash to break up binary files
Date: Thu, 31 Jul 2014 20:26:30 -0700
Message-ID: <CAJo=hJtQXb_0G0iqSdVWFwvWnCvowiL94S3UeG18BAkp2ih57Q@mail.gmail.com>
References: <D7F507613B1F45379A43C1BCF2F088B0@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 05:26:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD3Ue-0002ZT-MF
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 05:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaHAD0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 23:26:52 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:51842 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbaHAD0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 23:26:51 -0400
Received: by mail-ig0-f171.google.com with SMTP id l13so808643iga.10
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 20:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KOwoURqd9+sxEpmQZodxMJTJazS9pznEi+E4y5gK4QU=;
        b=BgqpBzXMWiOjqujtkrnFBkLClIG0oTDBx513mThwkc9MEjCKyTngTCGtR1iE4vOh4p
         iYLVpH2lECaxTOhBMmDEEpTLxu77zr1RevELcXWnChcJenLHK4o/Nj9E2Da9ovNLE+VW
         ZxK3/5dEUD1DbPED1+aCCreUmnzCrl7H2XCfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KOwoURqd9+sxEpmQZodxMJTJazS9pznEi+E4y5gK4QU=;
        b=TfgcOrBxtXFFaTsBYMBjMOTa51nRHCgN10bLbhGwsjhk8wjN17Bjf7zI3xnW//NuN+
         7pSvKosdluwXdEc2Vhy7DND20xPxOAUsxAqPZq1FNfor9mUjqdwvUdD+RZ75KFAvSImf
         56JWAMSzpT1Rb7hTtYYQWse0u/Lfr49N47LknHr6caH9AyJixxTLuNwJbHIEDtHpsLfc
         KHqwuujjsM2Yi8xPgj8l9o8SXoCgaSMft3xzma7b/72tn8dVTkSK0W4t3jlC7bnhmWft
         b5D4TWR6K/Qhksb9IWhYYfPSwyv2YTmsC6ElScfJ46XROt+3SKDq+Qo4pfDLGsAA+jXx
         c+WA==
X-Gm-Message-State: ALoCoQl1tRWwcVrpQtT37GBrpV+l/IwysFvda6JO9CvdrvBpQ3QjaW4jgKMm6LIdksSuPVvtlF23
X-Received: by 10.50.2.42 with SMTP id 10mr2670697igr.33.1406863610490; Thu,
 31 Jul 2014 20:26:50 -0700 (PDT)
Received: by 10.64.208.38 with HTTP; Thu, 31 Jul 2014 20:26:30 -0700 (PDT)
In-Reply-To: <D7F507613B1F45379A43C1BCF2F088B0@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254619>

On Thu, Jul 31, 2014 at 3:31 PM, Philip Oakley <philipoakley@iee.org> wrote:
> I thought it worth bring to the list's attention a  recent article on
> CodeProject that may be of interest to those looking at splitting binary
> files into deterministic hunks.
>
> http://www.codeproject.com/Articles/801608/Using-a-rolling-hash-to-break-up-binary-files
>
> It's based on Rabin and Karp's algorithm
> http://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm.

If I remember right, this is how bup[1] works. Its certainly what we
do for delta compressing files.

[1] https://github.com/bup/bup
