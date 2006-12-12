X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [RFC] E-mail aliases
Date: Tue, 12 Dec 2006 22:36:59 +0000
Message-ID: <b0943d9e0612121436u6cf7c200i92ba056103a80b13@mail.gmail.com>
References: <b0943d9e0612120449k4a13ac85t313df1e460ed46e4@mail.gmail.com>
	 <7vvekhufib.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 22:37:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VtDhLaM6gV31z0NzVX6rIPv7rTyPo5hT76F0mnMGgiQdiiP/1US0MrZyPNeyaEB0NTYGWbwbTncO6PiQSS5wFt8qiAN4PXb0LnmsGpTXlAakhhYAkPXtr3AIejnGqqqOXe4Ec/m0DPk0wrGvFIBDSFD53x5dc7XhDYJJGFfHVbg=
In-Reply-To: <7vvekhufib.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34153>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGFa-0005li-9X for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932518AbWLLWhD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWLLWhD
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:37:03 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:37278 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S932518AbWLLWhA (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 17:37:00 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1079418nze for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 14:36:59 -0800 (PST)
Received: by 10.65.232.19 with SMTP id j19mr162872qbr.1165963019607; Tue, 12
 Dec 2006 14:36:59 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Tue, 12 Dec 2006 14:36:59 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/12/06, Junio C Hamano <junkio@cox.net> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>
> > sets the "To:" header to "linux-kernel@vger.kernel.org".
> >
> > The aliases are read from the [aliases] section in the gitconfig files
> > ("git repo-config aliases.lkml" in this case). I just want to make
> > sure than there isn't any other intended use for the [aliases] section
> > in the config files.
>
> [alias] is used to hold command-line alias, and it seems
> slightly confusing to have two sections that mean something
> quite different.

Didn't know about [alias]. It is indeed confusing to have [aliases] as well.

> Perhaps
>
> [mail "alias"]
>         lkml = linux-kernel@vger.kernel.org

The other option would be to teach stgit to parse alias files used by
mutt etc. as Eric mentioned in the other e-mail (and it doesn't look
difficult). The problem is that you would need to know how to generate
them manually if you use other e-mail clients or web-based services.

> if we are going to have other mail-related configurations that
> might turn out be handy.  send-email would want smtp-server in
> there, for example.

At a quick look, it seems that git-send-email already uses a
[sendemail] section. StGIT currently reads the smtpserver and
authentication information from the [stgit] section.

-- 
