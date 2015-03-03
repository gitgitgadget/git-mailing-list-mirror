From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [GSoC idea] Resumable clone
Date: Tue, 3 Mar 2015 08:02:59 +0700
Message-ID: <CACsJy8Cue+pxPbddkv1_yMD-SLFO4PjKgdCVX0V7YCn_kUArcQ@mail.gmail.com>
References: <CACSCj9wkx1cSqcMbkt8+2S0GCzuBNeUjXyb4=n5_K7QzL_jawg@mail.gmail.com>
 <xmqqoaob7yi8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 02:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSbFH-0005R7-A6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 02:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbbCCBDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 20:03:30 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33054 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbbCCBDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 20:03:30 -0500
Received: by igbhl2 with SMTP id hl2so20769295igb.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Tmthw5tAxm/2hOs/XTRJcWxqr/XFBvZ48jyCr0u4bM0=;
        b=0qihFl8XI5wz6ZpJhd4CxRY7t+kUZeUIaHanaHwWmT6FQV4pk1l0MscQIfWaC61eRG
         G+0N9GEgnebsTxgOrJIMuqoEVDcDqFqiOhX41XuzVcc3/1DfUbd/0ONnok8Av0DbDiJV
         MqvHaGTaHSPcXJwA5g8UrQo/5GYxP9hW9dEl3pabqNEw8LdP6/Xa9AhYF5+0zfWnrokL
         KrRxo6XfF6v4oTJ1aGu92q83KQeFI04fNV76yIqueSBuu3qFMGfIgHa2DHFAZJgnnzNs
         UDpTpVTRMeV4WAj4uk0mEF//VBQMaWQ3t2aAowaC7+jE9us0VgyeJO9fk6d3iuAoozvS
         IlvQ==
X-Received: by 10.43.0.138 with SMTP id nm10mr24085466icb.56.1425344609194;
 Mon, 02 Mar 2015 17:03:29 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 2 Mar 2015 17:02:59 -0800 (PST)
In-Reply-To: <xmqqoaob7yi8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264639>

On Tue, Mar 3, 2015 at 6:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Koosha Khajehmoogahi <koosha.khajeh@gmail.com> writes:
>
>> Among GSoC 2011 ideas of git [1], it was proposed that a GSoC project
>> could be implementing resumable clone for git. AFAIK, this feature is
>> still missing in git but could be a great idea to be implemented. Does
>> that sound OK to the community?
>>
>> [1]: https://git.wiki.kernel.org/index.php/SoC2011Ideas#Resumable_clone
>
> Depends on how it will be implemented, I guess.

I still want to pursue stable pack approach [1]. It's not a good fit
for clone case (cached bundles would be much better). On the other
hand it does not need special support like cached bundles and can work
with upload-pack-v1. It might fit in gsoc scope. I guess whether it
may have a chance to get merged after gsoc is the deciding factor.

> I highly suspect that it would not fly well if it is added as a part
> of the current protocol, as people are actively discussing how to
> revamp it.  And I have a feeling that the v2 protocol would not
> ready for a student to build upon by this summer.

[1] http://thread.gmane.org/gmane.comp.version-control.git/184490/focus=184705
Though what I had in mind (and patches) does not need on-disk caching at all.
-- 
Duy
