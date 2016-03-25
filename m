From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/GSOC] Git Beginner | Warnings for potentially destructive commands
Date: Fri, 25 Mar 2016 12:20:48 -0700
Message-ID: <CA+P7+xqkqfccQtWeKbURZt21i+gw=b7f0YHHuqeNzM7TH2m+6g@mail.gmail.com>
References: <56F51089.2050703@gmail.com> <xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 20:28:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajXPe-000507-NW
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 20:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbcCYT2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 15:28:46 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36945 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbcCYT2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 15:28:45 -0400
Received: by mail-ig0-f176.google.com with SMTP id l20so19160051igf.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tphYlzC8OxOX0Va61dJbhK3iguY+PLAY+/Gj4Wz876M=;
        b=s9rmntxruKPdUye3Shei/rS5JWJBlH/xmLM8Y7r2RUY7W7AxwZUjKwocqw58a/gv4P
         fKYcC1uhPo8WlqsS/aA6Rf5gV33gWvlBHLQK33VXO1pB0XS7j9t5K/I24uP/kafSLKgC
         OdtTRiXRbOzllxH+LuUY1H/YeepltdU7OLOIl4/gXeq/CNHsXBOFDwd5UrfkRyHkGo+0
         C4qVMev6a2QJyM9ZBHsgy6ZiK1Jcn09ysTT69qeWIn7aD+R1pg0kFfDFviYeQh5I2eNl
         icZRhnXxq7V3e3T2DwcfLixdTK1clzrAM4uxIYjtpGwkMfIFnAeIJWNvp2Kwm2epPCgT
         ZogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tphYlzC8OxOX0Va61dJbhK3iguY+PLAY+/Gj4Wz876M=;
        b=ipbqpXlh+hRuilNJIlv96KoFwDbU0D54P0C+wyK/rrcCNx7r87lpxh0fMBs2Y9CxBl
         auSK8t8QyCunsZo7PH1B7kQypROJbcnGIh0B/Pk0FohpVTr7TVB9YRC8DIOaJ5+e4MHu
         ZHd34dLAcjUF62u0Xf4kqo2NcN6Az3wmvq1NG9N9VMg+Mw9uvOYEI4tmdoxVAV+RpABN
         nGJNpHYbi+fYgLMmut0ePyjbfTBNxrR1AgXPKrwwKmgKPQ8jZpZk9Nghba2duT1ny1lh
         18UV/nGEpPj/K7WTeSxdUFbu0dGelATJJgCCSlPYhXCcvhfTluVx7KxtuwDKHv7p2/ub
         6EHw==
X-Gm-Message-State: AD7BkJJEszmT9y9Nb9zsAfMUvhMZTjqtxoQjLp6om2RTaU1oDAjD4GjZrdhSTqlkIT1nqTYwu8S+7F1C0Awx+Q==
X-Received: by 10.50.143.105 with SMTP id sd9mr96116igb.73.1458933667817; Fri,
 25 Mar 2016 12:21:07 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Fri, 25 Mar 2016 12:20:48 -0700 (PDT)
In-Reply-To: <xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289948>

On Fri, Mar 25, 2016 at 10:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The above two examples make me wonder if these should be static
> text.  "ggit rebase" and "ggit reset" have full information of the
> concrete branch names, commit object names and the actual topology
> of the history, so it should be able to give a description more
> tailored to the user's situation.  Instead of giving a fictional
> drawing with "For instance, Current state:", it should be able to
> draw the actual before-and-after picture based on where the end-user
> actually is.  I see _some_ attempts (e.g. with "<n>", mention of
> "(master)" and $BASE_BRANCH, you may have meant that they will be
> replaced with actual values), but I suspect that telling some truth
> (i.e. use of the real branch names) while showing pictures that do
> not match the reality (i.e. if the topology and the description are
> done as fixed text) would only confuse the users.

If possible, I would suggest aiming for generating the actual topology
that the user is seeing, customized so that it gives relevenat
information, rather than static examples. It may be that it is not
possible or the effort is too large for such a project. If the latter
is the case, then using only static text is better than trying to use
some but not all the available information, as Junio points out above.

Regards,
Jake
