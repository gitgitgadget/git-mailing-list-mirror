From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Tue, 23 Jul 2013 12:01:44 +0700
Message-ID: <CACsJy8A1gBh0u173FcOY6-yQ7gTHMR396HP=_1VRsyup9iO0oQ@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
 <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com> <7vy58x9aus.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 07:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ujs-0001lD-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 07:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab3GWFCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 01:02:17 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42284 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab3GWFCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 01:02:16 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so7834169pbc.23
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 22:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=B3yhsPKRLLVNP8co1pXmLECwC3xx4cq+kxI7tvJRdHg=;
        b=pEjaCvgWLzUi5nlnHWDyMt8tyihY8mBjIXwUc4w7HYJekMIRQinhuMhgReAkdF7suJ
         mTJ2o45mPVvCv6brrIEm3/M8AwegD2Aik00CsqjyszW40R+gMECzpElzrrlW5f+NbgEi
         rScOPQfZ2yr0sd3a2qGc00KDJyiiZ1i4yxu+n0itpLpm0Q3PWTfpTqlru+znbZ08eFG0
         1vFfoNpqVxCmCKPvZZFMM8DUVb2UyF4S6Up/aCktoy4JPWpZ6w82sbH5eY0nOyXzTo4G
         QDxANMYVRGyWk2zbCt/Hab2mQyg/YTnr4er/wtWrwfSg6+KiKA5Slx3DopddSf81fC6/
         CX5w==
X-Received: by 10.66.178.143 with SMTP id cy15mr31008597pac.105.1374555736028;
 Mon, 22 Jul 2013 22:02:16 -0700 (PDT)
Received: by 10.70.82.169 with HTTP; Mon, 22 Jul 2013 22:01:44 -0700 (PDT)
In-Reply-To: <7vy58x9aus.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231020>

On Tue, Jul 23, 2013 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> This one, on the other hand, changes the "shape" of the repo (now with
>> holes) and might need to go through the same process we do with this
>> series. Maybe we should prepare for it now. Do you have a use case for
>> size-based filtering? What can we do with a repo with some arbitrary
>> blobs missing? Another form of this is narrow clone, where we cut by
>> paths, not by blob size. Narrow clone sounds more useful to me because
>> it's easier to control what we leave out.
>
> I was about to say "Hear, hear", but then stopped with a question to
> myself: why are these "some people do not want them" paths in the
> same repository in the first place?

I think there are situations that splitting repos is not the best
choice but I can't think of any. There's one case though that such
"some people" exist: when they migrate from another version control to
git and do not want to change the directory layout (because it used to
work ok, because of the cost of updating toolchain...)
--
Duy
