From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] svn-fe: Use the --report-fd feature
Date: Wed, 13 Oct 2010 01:11:28 +0200
Message-ID: <AANLkTikoSedLFD7pnMvzWYLxCTURhc=1h=73s4uj+fcM@mail.gmail.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
 <AANLkTikxsP_DV2Tjwk9vNi1WZFFiFEjQjCjhcbc5FETf@mail.gmail.com> <20101012230344.GH15587@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:11:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5o0g-0002Jb-Lb
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab0JLXLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 19:11:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58986 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab0JLXLt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 19:11:49 -0400
Received: by gxk6 with SMTP id 6so713210gxk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hFAnFf+NOl6voJckZppDARk2y3fKuRHRgGwKy+W/eCE=;
        b=l9GzUPgB2OQEw9L0qfCYuOhWlCJUkgAB/iNIjqoI0jg+5uSypa0CX3pM4P84BBHL2/
         QtClR9tZAwiJvRg5XZcbM6zqXsqtzWXg+Ov14Pmt02Ku9ndUyaSu3kk/e4eA07D7oak3
         zwLEwnBOL/EWaW7MBXhvVfuQprM76arCKwAWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c0WvTylKf3H9eK/42zC8x1G+iaiMMLrm37IrJZcVN7igDL9T2SYlNCr50jgKMv+C7n
         n6sj+AI4fPEfMu+78kEp7dRP3TmrnmUE2MtEA2IHXzgzOn7E/F6M+bbiYkKVRJbUMYWE
         +SHFSKNKvE+5sCa6Vm23TlMAP3S4R3Wav6CO8=
Received: by 10.151.87.10 with SMTP id p10mr9278261ybl.101.1286925108469; Tue,
 12 Oct 2010 16:11:48 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 12 Oct 2010 16:11:28 -0700 (PDT)
In-Reply-To: <20101012230344.GH15587@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158895>

Heya,

On Wed, Oct 13, 2010 at 01:03, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> The caller has to take care of backflow of data. =C2=A0Even if the
> "cat" command were never used, at least 3>/dev/null would be
> necessary to avoid fast-import waiting forever for the frontend
> to read from it.

Why is that? If we disable the auto-printing of sha's wouldn't it only
write to the fd iff the cat command is used?

> One way to work around this would be for svn-fe to launch fast-import
> itself.

What would the pipeline look like then? In particular for git-remote-sv=
n?

--=20
Cheers,

Sverre Rabbelier
