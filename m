From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 2 Mar 2008 13:54:10 +0100
Message-ID: <1b46aba20803020454v322f061bi4f34a737e9e2b7f3@mail.gmail.com>
References: <47C98472.8000002@gmail.com> <20080302094031.GA2973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 13:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVniL-0006Ov-0D
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 13:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbYCBMyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 07:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbYCBMyM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 07:54:12 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:57621 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYCBMyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 07:54:11 -0500
Received: by wf-out-1314.google.com with SMTP id 28so5903970wff.4
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=db1/Z7cqy6B1GwFNA9JBCLNeT32KRY6u/MD7SaIgG6s=;
        b=GbNDU6Be4tzsHwHzKBmOw0Gkz3t5ko4E4gwyV1uH5SLtu7dhNHxEao/MIbojSejz6tPn5P4hUeuNAyuqD6dA/a4APfKrzFp2A9GY/h23RqY+L+LYzlDeToX33FTq9bJUjhst1AHcZFsF4PUnnY0NRMwj4mk1QFvSzLM8z8ghl3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IY57HSUedYEskCFi7vcQiHIzjYVmNRvhKHmnBJ8G+OwuVLami7Ad8RdP8oeb645e2s7tXav2qTxVV/3+V3hxc4btyz+Y8AHBQAlKmXLTmJsisv5utx3dherqriV+3MAc7ckYJcr10Ee0IW+8/cYF/l3YnMiJASK+5HH3aGspV/I=
Received: by 10.142.172.12 with SMTP id u12mr8306515wfe.16.1204462450637;
        Sun, 02 Mar 2008 04:54:10 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Sun, 2 Mar 2008 04:54:10 -0800 (PST)
In-Reply-To: <20080302094031.GA2973@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75777>

On Sun, Mar 2, 2008 at 10:40 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Carlos Rica, Sat, Mar 01, 2008 17:29:38 +0100:
>
> > @@ -169,40 +173,31 @@ static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };
>  >
>  >  int cmd_reset(int argc, const char **argv, const char *prefix)
>  >  {
>  > -     int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0;
>  > +     int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
>  >       const char *rev = "HEAD";
>  >       unsigned char sha1[20], *orig = NULL, sha1_orig[20],
>  >                               *old_orig = NULL, sha1_old_orig[20];
>  >       struct commit *commit;
>  >       char *reflog_action, msg[1024];
>  > +     struct option options[] = {
>
>  "static const"?
>
>

"static const" what?
options? cmd_reset? reset_type_names?
