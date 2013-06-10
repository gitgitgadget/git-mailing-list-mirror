From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 11:55:26 -0500
Message-ID: <CAMP44s2tqY7k0=8xHW3R1GzG9MrdmF3D=ewmn6etKi5uUvQSrw@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<7vppvvnetw.fsf@alter.siamese.dyndns.org>
	<CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
	<7v8v2il62c.fsf@alter.siamese.dyndns.org>
	<CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5NU-0007ZC-QC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3FJQz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:55:29 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:47844 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab3FJQz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:55:28 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so5938625lab.4
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ekaooqj/xs9sf8NzUvJdEVqG3b63rUx9tteaLi0uNpA=;
        b=s7ZN1gJt2TEhg0Hzlfjxx4m9NNlolmXry1AUKwvr7qnQuDt48mcWou5XBm32qjHRI0
         tvPmky1ZgNhsjsupauokicSyHaCt9Enm1YWKEHX560snWEoQPIol9A/kkb8/YHX51vnS
         uUzbKzylXyc+77wM1J5W1r0+xuCJOFlnHSLF1kgP4x/qJ6gxFmivA1yBLek4qkd1liPZ
         dcy/WG9T2B61Vku+fizzDCk0lOhxn8WDMQsFruhaTd4Hye8u53JkOtCu/Wlrpq+hpi3Z
         PMbEyBnqTSRlaLCOBJzQ6zZTIJcs2byC6w7qsxa7OVsS0/Kci82CFrrAP1oUGzOhoTI7
         6qlA==
X-Received: by 10.152.5.7 with SMTP id o7mr1980243lao.43.1370883326636; Mon,
 10 Jun 2013 09:55:26 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 09:55:26 -0700 (PDT)
In-Reply-To: <CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227321>

On Mon, Jun 10, 2013 at 11:53 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jun 10, 2013 at 3:32 AM, Junio C Hamano <gitster@pobox.com> wrote:

>> E.g.
>> convincing people that it is not worth their time interacting with
>> you, especially when there are better things to do like tending to
>> other topics, and you lose the chance to show that your patches are
>> good when they indeed are (I don't even know if these patches in
>> question are good, and I am not going to find out).
>
> You are hurting the Git project by doing that, and our users,
> specially our Windows users.
>
> I thought you were a good maintainer. But apparently you would rather
> listen to the people that only complain, rather than actual code, that
> actually improves things.

And this in fact has a name; *bias*. It is bad in any human endeavor,
and in logic and argumentation, letting yourself be blinded by who is
making the arguments, rather than the arguments themselves has a name;
ad hominem.

That is a mistake.

-- 
Felipe Contreras
