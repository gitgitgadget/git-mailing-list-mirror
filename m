From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 4/9] ref-filter: add support to sort by version
Date: Sun, 12 Jul 2015 19:07:46 +0530
Message-ID: <CAOLa=ZSi1i2x9iZrAK_mULp6NRUPDkJ=f26qM1Mfu=cmTiKUXg@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com> <1435232596-27466-4-git-send-email-karthik.188@gmail.com>
 <CACsJy8DYcTAB6OkpAf-5kQ0V09Jkw8KDTGbRvLRO4TVXAwK8Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 15:38:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEHSg-0003Ng-0N
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 15:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbbGLNiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 09:38:17 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33480 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbGLNiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 09:38:17 -0400
Received: by obbgp5 with SMTP id gp5so103403960obb.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AG6TLLlbuaVfA4K3NExXxNs09LePUGN7cTVOTQfd0LY=;
        b=xXgkVQaiqKgn984PTggJUlsisPlifItzHaKh+fBtcCivlbuWpIouXLMPQwllaMh3fv
         /yJC1PULlxDp0xopSPb97miXX74YWTWGajC1PKPXB81vyipzAUwgvdYis1SDWRNfNj1r
         QtSUKylZWh9j1oDhKFHH+UTwmD3cS6oE/w9ORrm1bgA36hHK2CJR2pBTvVBJB7BUgO3Z
         ALI1QdRLzVau6uaq8tbaV0a7vVSGYljDQeU5i4Jk5cXtHv0ERSC7Tz97i4EnGNOhJodE
         tyBy4GU3jLd/uTGmD/3b06kihbMOyUnb7R8sshGTQRh/+M+Rs17XWaULNwbPwIER5UPC
         xcwg==
X-Received: by 10.60.58.136 with SMTP id r8mr26604293oeq.30.1436708296194;
 Sun, 12 Jul 2015 06:38:16 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 12 Jul 2015 06:37:46 -0700 (PDT)
In-Reply-To: <CACsJy8DYcTAB6OkpAf-5kQ0V09Jkw8KDTGbRvLRO4TVXAwK8Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273894>

On Sun, Jul 12, 2015 at 2:39 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jun 25, 2015 at 6:43 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add support to sort by version using the "v:refname" and
>> "version:refname" option. This is achieved by using the
>> 'version_cmp()' function as the comparing function for qsort.
>
> If these v:refname and version:refname are from git-tag, you may want
> to see [1]. I would say "version:" or "v:" is in the same class as "-"
> (for reverse sort) and they should be parsed in
> parse_opt_ref_sorting() instead. They should not be treated as atom
> names. By stripping "version:" before pref_ref_filter_atom() is called
> in this function, you make "version:" work with all supported atoms.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/242446
> --
> Duy

Thanks for this, what you're saying makes sense, will follow.

-- 
Regards,
Karthik Nayak
