From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/3] fix push --progress over file://, git://, etc.
Date: Thu, 14 Oct 2010 03:35:40 +0800
Message-ID: <AANLkTimo=Bd_XGvX=TPzVsds3xQGy9126+7Qg+zvk=d2@mail.gmail.com>
References: <20101012192117.GD16237@burratino>
	<20101012193204.GA8620@sigill.intra.peff.net>
	<20101012193830.GB8620@sigill.intra.peff.net>
	<7vzkuim1zx.fsf@alter.siamese.dyndns.org>
	<20101013174543.GA13752@sigill.intra.peff.net>
	<AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
	<AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
	<1286998311-5112-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P677L-0008AI-HC
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab0JMTfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:35:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58120 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab0JMTfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:35:41 -0400
Received: by ewy20 with SMTP id 20so2565651ewy.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0qEeSgsV2tyxDnM9CN+7dPxVPaXlwt4oXcH9Qd6nPTg=;
        b=nMTvFVEBYwZKrOJr8wDljXCj9ejiCiFH155pTQk9B8DdczYlxwjllwXmnWl/rUSgWB
         B1+420WsOdVLBvaWEhnZyUzcaSvSM9L4h4PbkAdzedOWQSFlzVXJhSg5tcdwDxsf5oHz
         3AwSFDHpdRxzgSUKe7ciQ7pOO6amgVysMxzX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dFMUeKJEluhu2Tua9SxeL36vlY2Y1PiKSxu8K6Y+PzjdKALhFsJ3jtoBAfi2Hr5fg7
         Q7kbFdSDsGEn5RplXES8jg5ksLfvUQtNNQvQH+/d3SSAAjpBnJaDWIaLa9ImhkhvmBzJ
         etvUPI4KUh3OafXJUGUNbhMyIquWnK3sApu+I=
Received: by 10.213.31.135 with SMTP id y7mr342460ebc.21.1286998540673; Wed,
 13 Oct 2010 12:35:40 -0700 (PDT)
Received: by 10.213.33.197 with HTTP; Wed, 13 Oct 2010 12:35:40 -0700 (PDT)
In-Reply-To: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158971>

On Thu, Oct 14, 2010 at 3:31 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> *** BLURB HERE ***

Whoops. Let me try again:

This patch series addresses the issue of git push not displaying
progress messages to non-tty stderr, even if --progress is used. As
suggested by the subject, this issue afflicts the "builtin smart
transports" - file://, git://, ssh://. (All of them use
git_transport_push() and thus git-pack-objects.)

-- 
Cheers,
Ray Chuan
