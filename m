From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7610-mergetool.sh test failure
Date: Fri, 27 May 2016 12:58:15 -0700
Message-ID: <CAPc5daV1zAwAHDmkc93kGvwCEFoioZNVta2xGsFJj9jq1H1H4A@mail.gmail.com>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net> <20160526015114.GA12851@sigill.intra.peff.net>
 <20160527044027.GA26143@gmail.com> <20160527050054.GA25774@sigill.intra.peff.net>
 <xmqqshx4row8.fsf@gitster.mtv.corp.google.com> <20160527182444.GA1871@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 21:58:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Nu4-0007nN-8a
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 21:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbcE0T6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 15:58:36 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35646 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbcE0T6f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 15:58:35 -0400
Received: by mail-yw0-f172.google.com with SMTP id o16so115725441ywd.2
        for <git@vger.kernel.org>; Fri, 27 May 2016 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5UN862Ky9VAGHzb1hECK0FHm8mTD3YnwDXtz5N3CcAI=;
        b=Pr/GQsrJX4NrUlRwhSj6i1pcEkNVdOqvLIAfm9pwf1179RLVJ9crM05uDqonux8+xy
         NUQBYuP1yUOXlDEYVTpdHC9ZGU6yai2oPvvjyCriVeCvUCrmTDKsscLGM36Ib75J49B+
         9KXa+VfRcprJC+cdDfs2GUeNgIfkBX0Qkt/rvFB1EBND0068gO/OhrZ1laUK9yQrhywn
         mFQxNKlst41MEu0nwfwh+FfA/HQj0LWV5sZph+sIgLIxO0PfqWQrDIlJKZiLjKS2MGOK
         o6iRvQC4Uj3o5vODRZ0WPbC5w0cTC1e90SE0k6XRk7lQbV2oURjmyJmwFov6Kv6AZkL1
         nIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5UN862Ky9VAGHzb1hECK0FHm8mTD3YnwDXtz5N3CcAI=;
        b=SGYJy4x9I9rhzzeIBvzpRwpNPW+Zz1OV1TfmJa1Uix/fnSQMNTOxmnaUh3y/wjoGyU
         4AzWfy4fj1IGjWKVxEBTpBVBzwZfNlAL+VusP2l8dosoT8hZ5BVt+vQA/L9jF9OX35fJ
         zsL8VJpxhw3Lt2lfiC6pui4flyJKPQkxzlUPRoaYL+qfKo/0pA2DfWj1hmvxhIXigwMk
         MDGGKV7/3WMP1Hmcf/3qleSnrEAskXkwLT0/66CVTKYITOd8OTDCSakMMnlJrIXzO/11
         PzEnFQv4lsOy7LHKxJ65lqoMaDWmTLbg6YhVoAD/2H6c7kLZor4GSckDIBfGNekUl3I5
         av8g==
X-Gm-Message-State: ALyK8tL5FoOTwXMp58qVVCaE00iH+2dm2CIRnYsN5+bpgkW8SFiE6Qw6RULqpuq1EpMmDGh9dzgWWcslpym2MA==
X-Received: by 10.129.98.138 with SMTP id w132mr8319400ywb.191.1464379114654;
 Fri, 27 May 2016 12:58:34 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Fri, 27 May 2016 12:58:15 -0700 (PDT)
In-Reply-To: <20160527182444.GA1871@sigill.intra.peff.net>
X-Google-Sender-Auth: I8xH6Brngoo9q6yzNSlNWIAIty4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295790>

On Fri, May 27, 2016 at 11:24 AM, Jeff King <peff@peff.net> wrote:
> Which perhaps shows that maybe some people would
> see a performance regression if we moved from /tmp to a slower
> filesystem (e.g., especially people whose git clone is on NFS or
> something).

Yup, but they would be using "--root" already if NFS bothers them;
having TMPDIR pointing somewhere in it would not hurt them, I
would think.
