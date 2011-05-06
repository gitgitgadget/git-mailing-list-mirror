From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: move private shopt shim for zsh to __git_
 namespace
Date: Fri, 6 May 2011 00:46:04 -0500
Message-ID: <20110506054604.GA13351@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie>
 <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
 <20110427064033.GB4226@elie>
 <BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
 <20110427091140.GB14849@elie>
 <BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
 <BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
 <20110427212704.GB18596@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIDrz-0006fF-9A
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 07:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab1EFFqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 01:46:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33033 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab1EFFqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 01:46:12 -0400
Received: by iyb14 with SMTP id 14so2406937iyb.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CM2+Ud8LboBnsdAJoHErd3/sB/6gv23K7XSuYIrMZc4=;
        b=w6fqf+9/EiOPQjI7MydkfG3jdjjnYcgs73QxEKTHyZH1E9lUTYpLoUv7OQ5ZOhpTsa
         kxvidQbTAUccBUv8bz4TARUuzDAiBoUW0BgZnsWI7gQ1psLtA+onjxDrVE8tfSH95TGN
         OB0ZbRO8QMxYLTFtW3iewquIW/Sr3sZTAAh5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Nu9EMTNBK/ZBHRUihWbiN7WrM5MNRmfM1F9DlchLdQHuBvA+Eg+USdKf3LpBYZBUUJ
         +rxuHoVO6WVHmVyYhirsn1gpHLMdmE6bmQetimCU2C4tzyiqtC58m8PbiuIy1kTf8HHI
         MIF4SddB2BhDsGRI48xXQ2Ui917kUzkzGNZBE=
Received: by 10.231.207.71 with SMTP id fx7mr1865306ibb.168.1304660771165;
        Thu, 05 May 2011 22:46:11 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id f28sm1212361ibh.67.2011.05.05.22.46.09
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 22:46:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110427212704.GB18596@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172944>

(culling cc list of quiet people :))
Jonathan Nieder wrote:

> Most zsh users probably probably do not expect a custom shopt function
> to enter their environment just because they ran "source
> ~/.git-completion.sh".
>
> Such namespace pollution makes development of other scripts confusing
> (because it makes the bash-specific shopt utility seem to be available
> in zsh) and makes git's tab completion script brittle (since any other
> shell snippet implementing some other subset of shopt will break it).
> Rename the shopt shim to the more innocuous __git_shopt to be a good
> citizen (with two underscores to avoid confusion with completion rules
> for a hypothetical "git shopt" command).

By the way, I meant the above[1] as a genuine patch submission.
Thoughts?  Bugs?  Improvements?

[1] http://thread.gmane.org/gmane.comp.version-control.git/172142/focus=172275
