From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Fri, 13 May 2016 21:45:50 +0200
Message-ID: <CAP8UFD05JuxG21MAV0wSYz+Vzqb8-unjW-rOSJ_c9YWWOoTTSQ@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
	<xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
	<xmqq37pndn2x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 21:46:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1J24-0004Hu-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 21:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbcEMTpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 15:45:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34937 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbcEMTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 15:45:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so5606181wme.2
        for <git@vger.kernel.org>; Fri, 13 May 2016 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UrN3jm5BhrJr3W7DLQU4asqhBJs45a9LdlLdrD1d08g=;
        b=0puFP+rkNcr639cS+hSxIiATDy4VKZOG3T+IU3As14y1CDJ2iH2yfcniJ1SLXkKB5Q
         g92nVpV0ZUJCozLtqTImuouiiebcN0NSmWQyWbyWj990nyH0uUNyXArmaFPrEtHi6dJa
         82ItqZBCdxE9lRI/z2r722n/20DC7WwewlSBvfKbm/DXOAzRND6gnmumXuOKT1X8HlX0
         pv4+zaFemXdMwIXIoEpAAHCsoR43D8VWjZqEQidnSbDp8r7MMk2GiZH3bYo80wsEt1wp
         chDsidXSMs+xm+dYySiig7jnvQUQ/LZk4FSzmDJ7K41Q0s+pcjlEZwB+lVnjhYsv2+kY
         mzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UrN3jm5BhrJr3W7DLQU4asqhBJs45a9LdlLdrD1d08g=;
        b=mvgL8CHI7i5T6Ly5P6bDMW1gW7o6g7EKMomxW7ozpn4CPdX/sDolQcA+cEPnCS+Nrz
         008rC6eIBp+PA3QAwsnSy2bEUtoowdBa3fk2BZRRLqAEqpLdFW2FABw4uTxBfhpTgw5w
         OFX5pesTqIRuTBXud0HvhTV4k2N/IkGS0qSJVyBav4xngEIRqSDcpJhYqgnFh1I1nUzs
         inXNsv0ChgWdwSN2ye+GtI+VxMy6yrWb8qtB93E/R+G+vrN5GIz17RkOmpFd6jcuNr+m
         tm3NSfhvX30OJMYwPDa48EkITE32eGzsvsYdKaTsllaS7Jo7OXK1rIfYZVHs58lTEs+O
         uu4w==
X-Gm-Message-State: AOPr4FXDU4oUspY4KSQJdzLj03tMHUC4GX7wRc76kQvpgGABcq6rPPNovAc3XNhaI7iLb709oGRGHMsBLFmn/w==
X-Received: by 10.194.20.162 with SMTP id o2mr17189771wje.78.1463168750324;
 Fri, 13 May 2016 12:45:50 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 13 May 2016 12:45:50 -0700 (PDT)
In-Reply-To: <xmqq37pndn2x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294560>

On Thu, May 12, 2016 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Up to this point, the conversion looks quite sensible, even though I
>> think the organization of fields in apply_state do not look logical.
>
> I'd stop here for now, as everything before this step looks
> uncontroversial.  Anybody whose tasked to move the global state for
> these variables into a structure would reach the samestate after
> applying these 48 patches, modulo minor differences in the way the
> comments would say things, how the patches are split and how the
> fields in apply_state() are organized.
>
> One thing that is missing is a counterpart of init_apply_state().
> In the early part of patches where it added only "const char *"
> borrowed from the caller and fields of intregral type, the lack of
> clear_apply_state() did not mattter, but with a few fields with
> "string_list" type, anybody who want to make repeated call into the
> apply machinery would want a way to release the resource the
> structure holds.
>
> Because 49/94 is a step to add an unfreeable resource, this is a
> good place to stop and then add the clean_apply_state() before that
> happens, I would think.  After that, I think both the contributor
> and the reviewers would benefit if these early patches are merged
> early without waiting for the review of the remainder.

Ok, I will add add the clean_apply_state() and resend the patches up
to that point soon, so that they can be merged early.

Thanks,
Christian.
