From: Jeffrey Middleton <jefromi@gmail.com>
Subject: pager config for external commands
Date: Fri, 19 Nov 2010 09:26:59 -0600
Message-ID: <AANLkTimMSp8XVzoaax2mW-jYP26B+zF2QSJFcy4TUi60@mail.gmail.com>
References: <AANLkTimtjR0O3K8iGOVVVaFJS2+2wHcHhWf45tFYXjRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 16:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJSs3-000838-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 16:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab0KSP1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 10:27:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34230 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab0KSP1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 10:27:21 -0500
Received: by eye27 with SMTP id 27so2727661eye.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 07:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=vXOBhG0Y82tLCNmxRFb1HTRcqXNYfU452WkQtW8lAa8=;
        b=vav40aLHdUlmhSXG9TAkLz2KBc6w536Cf7OV9JWHNHCtMBe4OkhWJBy2Glpbfc8sUw
         KlRhkyRhODSvCxWUyxsRD7s0wRZbK2lMHIzZl+Mt7pHQKP33r0OpfInKJ7SJq3br6mF/
         0GJxoOC1V0DvPpKv/jJhBCkgp9atq1TQfSdJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=F2AHL8aUyoOZUcYgBqHeGJDcWnpZq2TRRQXae4EhJN9SRnBD6e2/xPICbCWQiAShx9
         5f8u6EKNqieCDNjxUyUEXXyZSN+CtlZeW6OxbiqiOrACIAjAsPfD+dup90i+Qwj4OsiQ
         WNKS0NtVwEC7DxgjKNfBJmkhyFyVBl+BRgXao=
Received: by 10.216.166.68 with SMTP id f46mr1126387wel.26.1290180439868; Fri,
 19 Nov 2010 07:27:19 -0800 (PST)
Received: by 10.216.206.30 with HTTP; Fri, 19 Nov 2010 07:26:59 -0800 (PST)
In-Reply-To: <AANLkTimtjR0O3K8iGOVVVaFJS2+2wHcHhWf45tFYXjRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161756>

External commands don't appear to support the pager.<cmd> config
setting. It's implemented for builtins via the call to
check_pager_config and associated code in run_builtin, but there's
nothing like that in execv_dashed_external. Is there a reason not to
implement this for external commands? I can't see one, since the
--no-pager option does apply to them.

Thanks,
Jeffrey
