From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 04/15] ref-filter: introduce struct used_atom
Date: Mon, 25 Jan 2016 11:43:43 +0530
Message-ID: <CAOLa=ZTpmJECi+ftX_p_3ZXu7zSohPc+umJcw=WepbBBYs1uWA@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-5-git-send-email-Karthik.188@gmail.com> <CAPig+cSRDhbHmn5NSp_S4J99igFhBEpWfVMBKBDHCWAHN7-8qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 07:14:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNaPp-0000jR-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 07:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbcAYGOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 01:14:14 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32788 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcAYGON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 01:14:13 -0500
Received: by mail-vk0-f68.google.com with SMTP id n1so5293615vkb.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 22:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IMRu14tokJibzCQe+obzVfE0VoRX7bvxN1yEpQMNY8A=;
        b=Ipl6rNgW7P14DZQZ3CKsHrJ6Y3rc9VdubrsDGz2FbAlgdPjDSn9h3HWHv7MXvJIWii
         WAzthMj6pUxxkE9xawYBUVCuQXe7H2C6BDKSlxM0GGzpGQ88hWt+h5K5Bwk579CSIRQc
         ZCobHvvjgyBYJIiwfpkXhNZEN7yHyJTb39hu5Kcz4MtZLcJTb4nP4SZWJZ3lx5WFgTQ6
         p7ZTBm6zU2StW1V0Fz8YPcxQE6zAkT+sgqMHJCY8LfS4MZDLEWUb0uXuBtV30xuFrQvP
         JFKRYUq9Zq0Bf4BGoEU02+PpIzxwZ9ZL8sdE/WpEZHvozguAmHEON0LC+ksq9Dg+gOdL
         Os1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IMRu14tokJibzCQe+obzVfE0VoRX7bvxN1yEpQMNY8A=;
        b=eo77WdJY1Knnzgzr7YW44iroRQ9rwi1U1/b9j4bYug2ngf8ERfPxWeeFaq8gh6VUkt
         5pukevtY/qgzBv71o8QV24nROY1zxZ3Z4jjU/4gMjUO/yndtXstG3FDBFu26FneXo0yL
         UXK8jFYygz22+Pc/qqr90dccLjKP2P99YS6R24yPK5b/oK7aKDzRhKs8EcOz7sjbsn/A
         fqMejNAWORTU5HSnkoLVPnAQ174PdAXAjRFk5+Xtt+usGtbTtyJbsIxfFCjBOA51T6We
         46JexPnSTr03JVmOwlJ6M5rkzaSymlERnKMF/dg4Vs+suaNPg8+ZpZpP8KWXDqX96lsU
         cQIQ==
X-Gm-Message-State: AG10YOQVRKyyMDYQsJvHR5bpmARxVe0O2PfD7wzy0OmiIkLlaAL67xBl5qrjPOczcj7AqVub3+jMD7X2+nBoGQ==
X-Received: by 10.31.167.75 with SMTP id q72mr10206634vke.71.1453702452348;
 Sun, 24 Jan 2016 22:14:12 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Sun, 24 Jan 2016 22:13:43 -0800 (PST)
In-Reply-To: <CAPig+cSRDhbHmn5NSp_S4J99igFhBEpWfVMBKBDHCWAHN7-8qQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284717>

On Fri, Jan 22, 2016 at 12:34 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tuesday, January 5, 2016, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce the 'used_atom' structure to replace the existing
>> implementation of 'used_atom' (which is a list of atoms). This helps
>> us parse atoms beforehand and store required details into the
>> 'used_atom' for future usage.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -17,7 +17,7 @@
>>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>
>>  /*
>> - * An atom is a valid field atom listed above, possibly prefixed with
>> + * An atom is a valid field atom listed below, possibly prefixed with
>
> This particular change should be in patch 3/15 which moved this comment block.
>
> (Yes, it's true that this will make the patch something other than
> "pure code movement", but this change keeps the moved block logically
> consistent and that it's an appropriate thing to do -- plus it's quite
> minor.)

Will squeeze that in. Like you said it's too small so it would make
sense to bundle it
within 3/15.

-- 
Regards,
Karthik Nayak
