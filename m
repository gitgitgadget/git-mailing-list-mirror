From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 12:25:45 +0700
Message-ID: <CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <201310212029.01589.thomas@koch.ro> <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
 <201310211249.49568.mfick@codeaurora.org> <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
 <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
 <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com> <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
 <8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Oct 24 07:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZDR6-0004DW-RW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 07:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3JXF0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 01:26:16 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44528 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab3JXF0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 01:26:16 -0400
Received: by mail-qa0-f46.google.com with SMTP id j15so4775849qaq.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 22:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=egHwvpbMO5g/Dcc7SbZO32pf4ByCUOO40wJt6eIeVX8=;
        b=VCXMn4I4EI6yawPkOBPpqB2MWaS3MhSJKcO0MHcvMdIMkzimGC404EPhOFLlPHJPXF
         oXAYo6l/qjSmj1eZWysb/XAQj0Si7upQOENzQoBoxIcLPLEgC9zgRljOrmzu8aa20zY3
         kPa01UK7S7rkHCK2lSIbm7LFyGWYKDrrD+LvrMzAw6oU+/weFFjIuK83/hH7N6/bedut
         G5scVjbljBt25IeoV4XE1LNaTOaoXdgkYmiOqXarF7Fou6cbZVFJ98dNeKfCZnA2YTjt
         guRd8/+ATong0LcPcxvwza9qV7mFSYi9Ju7iMlVKAKfDbkRTQlE+gDsHFBvGDm/W+PDN
         JW+w==
X-Received: by 10.49.15.129 with SMTP id x1mr998459qec.49.1382592375564; Wed,
 23 Oct 2013 22:26:15 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 22:25:45 -0700 (PDT)
In-Reply-To: <8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236565>

On Thu, Oct 24, 2013 at 11:11 AM, Nasser Grainawi <nasser@codeaurora.org> wrote:
>>> It is not clear to me how you envision to make it work.
>>
>> I don't have the source code.
>
> Now you do: https://gerrit.googlesource.com/gerrit/+/master/gerrit-server/src/main/resources/com/google/gerrit/server/tools/root/hooks/commit-msg

Thanks. So you do have tree sha-1 by running "git write-tree". But at
that point I'm not sure if cache-tree is written down to disk yet, so
write-tree could be more expensive than necessary (one good point for
building --change-id in).
-- 
Duy
