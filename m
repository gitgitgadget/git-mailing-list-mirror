From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: concerns about git
Date: Mon, 13 Oct 2008 19:40:18 +0100
Message-ID: <e1dab3980810131140p45c62e5cs690ac190eeacc38e@mail.gmail.com>
References: <19959918.post@talk.nabble.com> <20081013181941.GT4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: deepwinter <deepwinter@winterroot.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpSMO-0001P6-H0
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 20:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870AbYJMSkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 14:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756796AbYJMSkW
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 14:40:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:46453 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714AbYJMSkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 14:40:21 -0400
Received: by qw-out-2122.google.com with SMTP id 3so498352qwe.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E4q07KpF5TJw0mmhGI7+cODAA5w3O/k5BUQdekaS2nk=;
        b=Nmw74Hwq82B5UCq8FGzr9IR5gkamYNI05T3QEC/hrLacVmGiZDey5FFAOgbZej8v5c
         Aj0hTtzDRRQsNpBnG9pKpVl1xtQuhYJu6n87MHOAcDY6Ut5TYdGnHPXjT5Hqq9auErMk
         1TCl2xikqFC1dI8RUgniS7d2kp/UWCeqmFPFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZJQKA0mzpwQM71H3+gfyeKaxmQKq6LyF7+cnQWxduXpgYCVrZU240rkvFXTx7ZkhYF
         5ER/Z0Q7x1Wc8C25CzVqLMGIcqOExNGxA0aRFqiFEkzMXlETJej6WiIqM/PY629xY5Cw
         o7dyNpuEUt87lYgvKuTqdKJ0oPxEcBlj8Y5+Y=
Received: by 10.215.39.16 with SMTP id r16mr5358327qaj.57.1223923218736;
        Mon, 13 Oct 2008 11:40:18 -0700 (PDT)
Received: by 10.214.81.8 with HTTP; Mon, 13 Oct 2008 11:40:18 -0700 (PDT)
In-Reply-To: <20081013181941.GT4856@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98139>

On Mon, Oct 13, 2008 at 7:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>  # then every once in a while, or from a cron job
>  $ git push --all backup
>
> Of course since Git is distributed you can you use this same approach
> to make backups to other systems.  You can even edit the .git/config
> to give the [remote "backup"] section more than one url line, so
> that "git push --all backup" will send updated copies to multiple
> locations at once.

Another advantage of 'git push'ing to another repository (possibly via
cron) as backup is that (for technical reasons) git push has to
'parse' the new changes to your repository in order to push, so it is
likely to spot corruption (eg, dying disk) at that time and when you
can decide what to do about it. (I have enough backups all over the
place that I don't worry about not having a 'copy' of any stuff I care
about, but that there'll be some fatal corruption I don't notice
immediately that then gets propagated everywhere rendering them
useless.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
