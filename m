From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 09:23:00 +0100
Message-ID: <n2ifbd9d3991004120123p7b08a8a2wee380454e9fe9a1d@mail.gmail.com>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
	 <4BC2D61B.7050902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 12 10:23:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1EvR-0005kY-Gd
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 10:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0DLIXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 04:23:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:26715 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab0DLIXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 04:23:03 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1931224qwh.37
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=2T9AYUZc5i+QYAVMEdzOW4e1aQqbyskY6DqutFSiU+U=;
        b=II8fjMtUGQ2ih0dEuiC/sqSc025/GMjadcSFhV1tF2YYSuYzpX3WcTh9YVUtpVSfNW
         Z/nusaTR03r9QCpItD/Ucu8zi7sWCOwVExhqhj4doIk4JMfoP4ca9LjRlWJrd2C8kgoR
         p+coztX1IfU9WN/bhLqiQKACG6VTVAe6CEW8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=U6pQ+pD2fit64BGYGXJHuSrhWew0zjkBJlMii4Fd+spidJelrAAMiQGBMvvzCVjqKy
         IHXuo4rCZVwoPhGIRb1BpSm0YeFqGfI0A0a7BubVDc5LmSgf/L9sDS8pYS4dn3CJpSbV
         1wmGrtGTLlDIZrXc52LlJmFNdeOT/R5ZP8Xcw=
Received: by 10.229.223.196 with HTTP; Mon, 12 Apr 2010 01:23:00 -0700 (PDT)
In-Reply-To: <4BC2D61B.7050902@drmicha.warpmail.net>
Received: by 10.229.239.148 with SMTP id kw20mr5542112qcb.10.1271060580963; 
	Mon, 12 Apr 2010 01:23:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144711>

On Mon, Apr 12, 2010 at 9:13 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> have you tried setting it to an empty value?

Yes I have tried it.  An empty string causes the SMTP auth Perl module
to choke.  It expects a non-empty username and exits with an error.

On my system I have patched git-send-email to perform this check:

if (defined $smtp_authuser and length $smtp_authuser) {

This works but feels like a hack.  I think unset override could be
useful for any git config option, not just sendemail.smtpuser.

I'm not familiar with git internals; do you have other suggestions for
solving this issue?

Stefan
