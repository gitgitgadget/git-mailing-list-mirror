From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 19:55:09 +0000
Message-ID: <be6fef0d0901171155p26e14aa1t90c0d7b8ec7925f3@mail.gmail.com>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
	 <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
	 <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>
	 <7vsknh7og5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOHHg-0001jQ-SH
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764519AbZAQTzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764340AbZAQTzO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:55:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:47570 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764336AbZAQTzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:55:12 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2056050rvb.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IuiTt+eEibB51w/zMW6/sr2kgVZn8kJgIcW6aB0G1xs=;
        b=sUdI//G680zl87/NR8YbE/6Hl6VlmCq82q1EAtvOHw2gNVFtp/hFSFbEo0y43JSP2p
         Dy5I6OLKPdOpd8iSe+bHWG9hrmml0EK1wLoZUfO8+0Z1JiNUC9GQmLaW2PBTk/+VgSOX
         nVXl4DsL5coCHnKBEvR6+xvuSRve7qW9XFAe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IfKXTH/2N5gCd4kd+EggHbEVSmLsmaax0MeZvIYdMSi+OY+L+9Sf0bET/If2AqwAsr
         9ieWSZwZdTqOZCkKdyIQu+Kgrq/r5BBor97B/RfCO3Kqx5oANAr/4vT4uZm25kf7AIxS
         NA59dVpCMniXU9BLWQvyEF/SHNifFUk0GAfkY=
Received: by 10.114.39.5 with SMTP id m5mr538263wam.41.1232222109684;
        Sat, 17 Jan 2009 11:55:09 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 11:55:09 -0800 (PST)
In-Reply-To: <7vsknh7og5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106098>

Hi,

On Sat, Jan 17, 2009 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ray Chuan" <rctay89@gmail.com> writes:
>
>>>> -test_expect_failure 'push to remote repository' '
>>>> +test_expect_success 'push to remote repository' '
>>>>       cd "$ROOT_PATH"/test_repo_clone &&
>>>>       : >path2 &&
>>>>       git add path2 &&
>>>>       test_tick &&
>>>>       git commit -m path2 &&
>>>> -     git push &&
>>>> -     [ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]

i modified the push arguments as there was no remote ref/branch
specified. With a fixed "git push", that line says:

  No refs in common and none specified; doing nothing.

i'd like to take this chance to inquire, what does the -f, plus square
brackets, really mean? i assumed it was to force push to go ahead even
if "a remote ref that is not an ancestor of the local ref used to
overwrite it" check fails.

-- 
Cheers,
Ray Chuan
