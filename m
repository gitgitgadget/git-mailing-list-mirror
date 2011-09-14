From: Chris Li <git@chrisli.org>
Subject: Re: [PATCH] git-p4: import utf16 file properly
Date: Wed, 14 Sep 2011 11:39:18 -0700
Message-ID: <CANeU7QnPqJ+igcmS1JX_vasCXr+Wpcx2b4Z-sy_=0qKEkG+v_w@mail.gmail.com>
References: <CANeU7QndA0yv1OzU3vta5B8r8nCRdBSqTy0Rboc_bbpst+1pcw@mail.gmail.com>
	<4E705DF8.1040508@diamand.org>
	<CANeU7QnW5kSni0W9M9q-FTWv4p_qc67LG3mA6BQj_U-wxNuZeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uUT-0005kt-OT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab1INSrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:47:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61756 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab1INSrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:47:16 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Sep 2011 14:47:16 EDT
Received: by pzk32 with SMTP id 32so4402278pzk.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=wD37bk916+ln3C8XaG8SxpBODMMJ0UQm4fwirJfMIms=;
        b=C9jIXOofK11EHvbZNY9JV+EfXQySZONXHR3wFfx5ObIPJyHFnZ2P83l+eVm6vyQgPB
         aK3DKMcJ8vTXgUvpyQIUuzGiL6FU8kLH2bvFjN91jEtiWu8fgCCfwXweeAI2lyhKqo+q
         HaDQTmrvn1Kw/9SkytxOxvGet/Xf6vstWJ+cw=
Received: by 10.68.44.194 with SMTP id g2mr409761pbm.51.1316025558565; Wed, 14
 Sep 2011 11:39:18 -0700 (PDT)
Received: by 10.143.76.16 with HTTP; Wed, 14 Sep 2011 11:39:18 -0700 (PDT)
In-Reply-To: <CANeU7QnW5kSni0W9M9q-FTWv4p_qc67LG3mA6BQj_U-wxNuZeQ@mail.gmail.com>
X-Google-Sender-Auth: RL_5lxaxQHNSibl3YmIWdKq_43I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181379>

On Wed, Sep 14, 2011 at 11:29 AM, Chris Li <git@chrisli.org> wrote:
>> Does this change do the right thing with RCS keywords in UTF16 files?
>
> I don't know what is the rules about the RCS keyword in UTF16 files.

I did a little bit research and found this:

http://www.perforce.com/perforce/doc.current/manuals/p4guide/ab_filetypes.html

RCS keyword expand should only happen for "+k" or "+ko" modifiers.
There for, "utf16" files without modifier should not be converted.
In that regard, the patch is correct. But both the original and patched version
did not handle "utf16+k" type of files. I still consider it as a separate issue.

Chris
