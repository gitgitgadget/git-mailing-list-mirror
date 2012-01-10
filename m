From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] sequencer: factor code out of revert builtin
Date: Tue, 10 Jan 2012 20:51:26 +0530
Message-ID: <CALkWK0mYPS+FRihHOGfoK52nvKfNh9rGFdy=_0hri+uqocRzBA@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-7-git-send-email-artagnon@gmail.com> <20120108203800.GM1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 16:21:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkdWM-00057t-Aq
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 16:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab2AJPVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 10:21:49 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64218 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2AJPVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 10:21:48 -0500
Received: by wibhm6 with SMTP id hm6so3476993wib.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2Rw4qGDCFdPBsjlKVymO8Ha1VU522GKBrI6eLMGRzdM=;
        b=p922GTtkO5TOjBZLGBsAIzaPiQ8IO9LPto2hi8wq/7dUy2oo9JoF+AEyAg2+z1FlbC
         R9gPpLEpG61plHsk7xQ+8nvijfq+dMVpOfSh9vO/fRZ4YFKrdpAdC32torhMQJnsBG8Y
         9EIueJ3p5TkL9YTom1LYISB6jFicYbLqF1Hv8=
Received: by 10.180.106.165 with SMTP id gv5mr35180283wib.18.1326208907552;
 Tue, 10 Jan 2012 07:21:47 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 07:21:26 -0800 (PST)
In-Reply-To: <20120108203800.GM1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188253>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> =C2=A0 memset(&opts, 0, sizeof(opts));
>> =C2=A0 opts.command =3D REPLAY_CMD_FOO;
>> =C2=A0 opts.revisions =3D xmalloc(sizeof(*opts.revs));
>> =C2=A0 parse_args_populate_opts(argc, argv, &opts);
>> =C2=A0 init_revisions(opts.revs);
>> =C2=A0 sequencer_pick_revisions(&opts);
>
> Hm, I wonder if opts.command should be a string so each new caller
> does not have to add to the enum and switch statements...

The new caller would have to add enum and switch statements to define
a new action anyway, so I think this should be an enum too.

-- Ram
