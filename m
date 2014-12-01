From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 1 Dec 2014 21:44:52 +0700
Message-ID: <CACsJy8CKEwOVcB_MUaK8mmSmQuKHC6R6K0YymjCrTP3aYFdbPg@mail.gmail.com>
References: <87vblxl8ah.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:45:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvSEC-0001yE-2J
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 15:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbaLAOpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 09:45:24 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60500 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802AbaLAOpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 09:45:23 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so9165213iec.25
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/Smpz3h3pn9R1Sb9CgSoqjS0IkVXTO1ZmaU3vbLtJQU=;
        b=QbhW7D2MvHtV8lG2eHWvLlcN0MUQYmGb3yZddBnTXXFMyXEisjCTOt+eVEQhzmkiIm
         3ljmknpRvtZaBj2b8GKND8hV8q4KRKilXXmiLgu2HdJG6wzFr/pmWBASDBM5O/5CXvdD
         oHp670fVTRUFTfYb+61PYNsE6ftaO2830uj7Nyac5KEaQ8rbaWV3x0HUmfDlKFfbch1c
         VeYsBstYiBUDsXUplShPNELdQ+rWoXT6tb+eDUjzwbPmoQuXwr4ilFnoMxuTBhxOfKYu
         c4ocJLcCSA8yZOZVbJlhEGzkWC06MwiS6R5kJDXxFUaeRlS/v/W8d6yWtoboGCZK9ptT
         jzmA==
X-Received: by 10.50.47.102 with SMTP id c6mr46858451ign.27.1417445122513;
 Mon, 01 Dec 2014 06:45:22 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Mon, 1 Dec 2014 06:44:52 -0800 (PST)
In-Reply-To: <87vblxl8ah.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260484>

On Sun, Nov 30, 2014 at 9:41 AM, David Michael <fedora.dm0@gmail.com> wrote:
> +int git_stat(const char *path, struct stat *buf)
> +{
> +       int rc;
> +       rc = stat(path, buf);
> +       if (buf != NULL)

It's a minor thing, but maybe test "!rc" instead of "buf != NULL"?

> +               buf->st_mode = mode_native_to_git(buf->st_mode);
> +       return rc;
> +}
-- 
Duy
