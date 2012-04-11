From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 1/2] git p4: Fixing script editor checks
Date: Wed, 11 Apr 2012 20:51:45 +0200
Message-ID: <CAE5ih7_X=4gewga8fMzaEvowsJsA1Ta9PQ2bGixx5eVvykputA@mail.gmail.com>
References: <1334157684-31402-1-git-send-email-luke@diamand.org>
	<1334157684-31402-2-git-send-email-luke@diamand.org>
	<7vpqbekx7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2e5-0005GB-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab2DKSvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 14:51:51 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38263 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940Ab2DKSvr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 14:51:47 -0400
Received: by wgbdr13 with SMTP id dr13so1204151wgb.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 11:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=+4J2rYXPaNAfJk8I7nFH8Sb0H/stlcdKZluZ2HP9J+A=;
        b=Gt7o06KMTBBJo7UOfeXFQuisDk0BvltgKtDk4/ceiNskJeVzx1oHY8vrSAndJYLx8I
         HE3sSJx0mYIpZpwL0xPS64Gj/BEUBQNAAge0JonBXRmsByTWJ4S9NhtwxXBiOMthjdsJ
         p6UKV2I7ERMcQl3outQJ6Am9/Qs6pCJgLbXFD73d2wMj9w0XCMgPmIXiylwu11b6T+50
         b9Rz6hXirwxBSeCETLjAcOou+LhNLt96k/dl+/hllKpNX/OZQC+vCWbaos+LnlqRVKA0
         4I5slGnMKetW2vx/umtcFOzUWsiUjtqRWKjhPxLR8SEuh0mZXSuOpL+0CKtAbsL/Gq14
         1CnA==
Received: by 10.180.104.230 with SMTP id gh6mr18516820wib.22.1334170305964;
 Wed, 11 Apr 2012 11:51:45 -0700 (PDT)
Received: by 10.216.204.27 with HTTP; Wed, 11 Apr 2012 11:51:45 -0700 (PDT)
In-Reply-To: <7vpqbekx7h.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkImB6xWjcxN+QT9GKELA3Uz+QkgCXL6JMolY8Xnqwx1vHCQTEmbWk9+r8JpJm16WPTFg6N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195236>

On Wed, Apr 11, 2012 at 7:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Luke Diamand <luke@diamand.org> writes:
>
>> If P4EDITOR is defined, the tests will fail when "git p4" starts an
>> editor.
>
> Is that a problem specific to tests, or should "git p4" itself unset =
that
> environment? =C2=A0If it is a problem specific to tests, would it be =
a better
> fix to add "P4EDITOR=3D:" like we do for EDITOR in t/test-lib.sh?

Yes and no - git-p4.py will run $P4EDITOR if it is set, even if it's
just empty. So it would need a small fix to check for an empty string.
I can submit a suitable patch.
